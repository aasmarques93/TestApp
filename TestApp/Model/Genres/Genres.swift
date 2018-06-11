//
//  Genres.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Genres: Model {
    var json: JSON?
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let id = "id"
        static let name = "name"
    }
    
    // MARK: Properties
    var id: Int?
    var name: String?
    
    // MARK: SwiftyJSON Initializers
    init(object: Any) {
        guard let json = object as? JSON else {
            self.init(json: JSON(object))
            return
        }
        self.init(json: json)
    }
    
    /// Initiates the instance based on the JSON that was passed.
    init(json: JSON?) {
        self.json = json
        id = json?[SerializationKeys.id].int
        name = json?[SerializationKeys.name].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = name { dictionary[SerializationKeys.name] = value }
        return dictionary
    }
}
