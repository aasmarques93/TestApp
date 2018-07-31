//
//  LocalStorageHelper.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 8/1/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation

struct LocalStorageHelper {
    static func save(object: Any?, requestUrl: RequestUrl?) -> Bool {
        guard let object = object, let requestUrl = requestUrl else {
            return false
        }
        UserDefaults.standard.set(NSKeyedArchiver.archivedData(withRootObject: object), forKey: requestUrl.rawValue)
        return true
    }
    
    static func fetch(requestUrl: RequestUrl) -> Any? {
        guard let data = UserDefaults.standard.data(forKey: requestUrl.rawValue) else {
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObject(with: data)
    }
    
    static func delete(requestUrl: RequestUrl) {
        UserDefaults.standard.set(nil, forKey: requestUrl.rawValue)
    }
}
