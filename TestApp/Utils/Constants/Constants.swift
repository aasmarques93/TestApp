//
//  Constants.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation

struct Constants {
    static let defaultDateFormat = "dd/MM/yyyy"
    static let dateFormatIsoTime = "yyyy-MM-dd'T'hh:ss:mm"
}

enum Titles: String {
    // Button Common Titles
    case done = "OK"
    
    case movies = "Movies"
    case tvShows = "TV Shows"
    case roulette = "Roulette"
    case allGenres = "All Genres"
    
    // Titles
    case error = "Error"
    case success = "Success"
    case click = "Click"
    case event = "Event"
    
    // Photo Picker
    case photos = "All photos"
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
