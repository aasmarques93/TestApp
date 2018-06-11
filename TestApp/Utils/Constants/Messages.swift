//
//  Messages.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation

enum Messages: String {
    case emptySearch = "There are no items available"
    case withoutNetworkConnection = "You have lost your internet connection. Please try again later."
    case serverError = "An error on our servers has occurred. Please try again later."
    
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
