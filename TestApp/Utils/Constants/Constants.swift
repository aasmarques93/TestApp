//
//  Constants.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 7/31/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation

enum Titles: String {
    // Button Common Titles
    case movies = "Movies"
    case tvShows = "TV Shows"
    case explore = "Explore"
    case allGenres = "All Genres"
    
    // Titles
    case error = "Error"
    case success = "Success"
    case done = "OK"
        
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
