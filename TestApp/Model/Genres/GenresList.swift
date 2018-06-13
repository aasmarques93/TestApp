//
//  GenresList.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/12/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation
import SwiftyJSON

struct GenresList: Model {
    var json: JSON
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    struct SerializationKeys {
        static let genres = "genres"
    }
    
    // MARK: Properties
    var genres: [Genre]?
    
    // MARK: SwiftyJSON Initializers
    init(object: Any?) {
        guard let object = object else {
            self.init(json: JSON(MovieShowsList.dictionaryErrorData))
            return
        }
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    init(json: JSON) {
        self.json = json
        if let items = json[SerializationKeys.genres].array { genres = items.map { Genre(json: $0) } }
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = genres { dictionary[SerializationKeys.genres] = value.map { $0.dictionaryRepresentation() } }
        return dictionary
    }
}