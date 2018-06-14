//
//  AlertController.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/13/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import SwiftKeychainWrapper

struct LocalStorageHelper {
    static func save(object: Any?, requestUrl: RequestUrl?) -> Bool {
        guard let object = object, let requestUrl = requestUrl else {
            return false
        }
        return KeychainWrapper.standard.set(NSKeyedArchiver.archivedData(withRootObject: object), forKey: requestUrl.rawValue)
    }
    
    static func fetch(requestUrl: RequestUrl) -> Any? {
        guard let data = KeychainWrapper.standard.data(forKey: requestUrl.rawValue) else {
            return nil
        }
        return NSKeyedUnarchiver.unarchiveObject(with: data)
    }
    
    static func delete(requestUrl: RequestUrl) -> Bool {
        return KeychainWrapper.standard.removeObject(forKey: requestUrl.rawValue)
    }
}
