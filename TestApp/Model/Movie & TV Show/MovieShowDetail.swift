//
//  MovieDetail.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation
import SwiftyJSON

struct MovieShowDetail: Model {
    var json: JSON?
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let backdropPath = "backdrop_path"
        static let voteCount = "vote_count"
        static let overview = "overview"
        static let voteAverage = "vote_average"
        static let imdbId = "imdb_id"
        static let id = "id"
        static let title = "title"
        static let posterPath = "poster_path"
        static let genres = "genres"
        static let runtime = "runtime"
        static let originalTitle = "original_title"
        static let originalName = "original_name"
        static let releaseDate = "release_date"
        static let popularity = "popularity"
        static let firstAirDate = "first_air_date"
        static let lastAirDate = "last_air_date"
    }
    
    // MARK: Properties
    var backdropPath: String?
    var voteCount: Int?
    var overview: String?
    var voteAverage: Float?
    var imdbId: String?
    var id: Int?
    var title: String?
    var posterPath: String?
    var runtime: Int?
    var originalTitle: String?
    var releaseDate: String?
    var popularity: Float?
    var originalName: String?
    var firstAirDate: String?
    var lastAirDate: String?
    var genres: [Genres]?
    
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
        backdropPath = json?[SerializationKeys.backdropPath].string
        voteCount = json?[SerializationKeys.voteCount].int
        overview = json?[SerializationKeys.overview].string
        voteAverage = json?[SerializationKeys.voteAverage].float
        imdbId = json?[SerializationKeys.imdbId].string
        id = json?[SerializationKeys.id].int
        title = json?[SerializationKeys.title].string
        posterPath = json?[SerializationKeys.posterPath].string
        runtime = json?[SerializationKeys.runtime].int
        originalTitle = json?[SerializationKeys.originalTitle].string
        releaseDate = json?[SerializationKeys.releaseDate].string
        popularity = json?[SerializationKeys.popularity].float
        originalName = json?[SerializationKeys.originalName].string
        firstAirDate = json?[SerializationKeys.firstAirDate].string
        lastAirDate = json?[SerializationKeys.lastAirDate].string
        if let items = json?[SerializationKeys.genres].array { genres = items.map { Genres(json: $0) } }
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = backdropPath { dictionary[SerializationKeys.backdropPath] = value }
        if let value = voteCount { dictionary[SerializationKeys.voteCount] = value }
        if let value = overview { dictionary[SerializationKeys.overview] = value }
        if let value = voteAverage { dictionary[SerializationKeys.voteAverage] = value }
        if let value = imdbId { dictionary[SerializationKeys.imdbId] = value }
        if let value = id { dictionary[SerializationKeys.id] = value }
        if let value = title { dictionary[SerializationKeys.title] = value }
        if let value = posterPath { dictionary[SerializationKeys.posterPath] = value }
        if let value = runtime { dictionary[SerializationKeys.runtime] = value }
        if let value = originalTitle { dictionary[SerializationKeys.originalTitle] = value }
        if let value = releaseDate { dictionary[SerializationKeys.releaseDate] = value }
        if let value = popularity { dictionary[SerializationKeys.popularity] = value }
        if let value = originalName { dictionary[SerializationKeys.originalName] = value }
        if let value = firstAirDate { dictionary[SerializationKeys.firstAirDate] = value }
        if let value = lastAirDate { dictionary[SerializationKeys.lastAirDate] = value }
        if let value = genres { dictionary[SerializationKeys.genres] = value.map { $0.dictionaryRepresentation() } }
        return dictionary
    }
}
