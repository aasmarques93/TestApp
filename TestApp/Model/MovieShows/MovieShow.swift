//
//  MovieShow.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 7/31/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MovieShow: Model {
    var statusMessage: String?
    var json: JSON
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    struct SerializationKeys {
        static let posterPath = "poster_path"
        static let backdropPath = "backdrop_path"
        static let overview = "overview"
        static let originalTitle = "original_title"
        static let originalName = "original_name"
        static let id = "id"
        static let title = "title"
        static let voteAverage = "vote_average"
        static let mediaType = "media_type"
    }
    
    // MARK: Properties
    var posterPath: String?
    var backdropPath: String?
    var overview: String?
    var originalTitle: String?
    var originalName: String?
    var id: Int?
    var title: String?
    var voteAverage: Float?
    var mediaType: String?
    
    // MARK: SwiftyJSON Initializers
    init(object: Any?) {
        guard let object = object else {
            self.init(json: JSON(createModelErrorData()))
            return
        }
        self.init(json: JSON(object))
    }
    
    /// Initiates the instance based on the JSON that was passed.
    init(json: JSON) {
        self.json = json
        handleStatusMessageError()
        posterPath = json[SerializationKeys.posterPath].string
        backdropPath = json[SerializationKeys.backdropPath].string
        overview = json[SerializationKeys.overview].string
        originalTitle = json[SerializationKeys.originalTitle].string
        originalName = json[SerializationKeys.originalName].string
        id = json[SerializationKeys.id].int
        title = json[SerializationKeys.title].string
        voteAverage = json[SerializationKeys.voteAverage].float
        mediaType = json[SerializationKeys.mediaType].string
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    var dictionaryRepresentation: [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = posterPath { dictionary[SerializationKeys.posterPath] = value }
        if let value = backdropPath { dictionary[SerializationKeys.backdropPath] = value }
        if let value = overview { dictionary[SerializationKeys.overview] = value }
        if let value = originalTitle { dictionary[SerializationKeys.originalTitle] = value }
        if let value = originalName { dictionary[SerializationKeys.originalName] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = title { dictionary[SerializationKeys.title] = value }
        if let value = voteAverage { dictionary[SerializationKeys.voteAverage] = value }
        if let value = mediaType { dictionary[SerializationKeys.mediaType] = value }
        return dictionary
    }
}
