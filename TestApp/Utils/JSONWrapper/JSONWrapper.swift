//
//  LocalJSONWrapper.swift
//  Figurinhas
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import SwiftyJSON

struct JSONWrapper {
    static func json(from resource: RequestUrl, handler: Handler<JSON?>? = nil) {
        do {
            guard let file = Bundle.main.url(forResource: resource.rawValue, withExtension: "json") else {
                handler?(nil)
                return
            }
            let data = try Data(contentsOf: file)
            let json = try JSON(data: data)
            handler?(json)
        } catch {
            print(error.localizedDescription)
            handler?(nil)
        }
    }
    
    static func object(from resource: RequestUrl) -> Any? {
        do {
            guard let file = Bundle.main.url(forResource: resource.rawValue, withExtension: "json") else {
                return nil
            }
            let data = try Data(contentsOf: file)
            let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            return object
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
