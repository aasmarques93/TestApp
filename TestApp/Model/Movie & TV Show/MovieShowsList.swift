//
//  MovieShowsList.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MovieShowsList: Model {
    var json: JSON?
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let totalPages = "total_pages"
        static let page = "page"
        static let results = "results"
        static let dates = "dates"
        static let totalResults = "total_results"
    }
    
    // MARK: Properties
    var totalPages: Int?
    var page: Int?
    var results: [MovieShow]?
    var totalResults: Int?
    
    // MARK: SwiftyJSON Initializers
    init(object: Any) {
        if let json = object as? JSON {
            self.init(json: json)
            return
        }
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    init(json: JSON?) {
        self.json = json
        totalPages = json?[SerializationKeys.totalPages].int
        page = json?[SerializationKeys.page].int
        if let items = json?[SerializationKeys.results].array { results = items.map { MovieShow(json: $0) } }
        totalResults = json?[SerializationKeys.totalResults].int
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = totalPages { dictionary[SerializationKeys.totalPages] = value }
        if let value = page { dictionary[SerializationKeys.page] = value }
        if let value = results { dictionary[SerializationKeys.results] = value.map { $0.dictionaryRepresentation() } }
        if let value = totalResults { dictionary[SerializationKeys.totalResults] = value }
        return dictionary
    }
}
