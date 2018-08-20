//
//  FileManager.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 7/31/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation

// MARK: - File Names -
enum FileManager: String {
    case requestLinks = "RequestLinks"
    case environmentLink = "EnvironmentLinks"
    case test
    
    static func load(file: FileManager, key: String) -> String {
        guard let host = file.contentDictionary?.object(forKey: key) as? String else {
            return ""
        }
        return host
    }
    
    var contentDictionary: NSMutableDictionary? {
        guard let bundle = Bundle.main.path(forResource: rawValue, ofType: "plist") else {
            return nil
        }
        return NSMutableDictionary(contentsOfFile: bundle)
    }
}

