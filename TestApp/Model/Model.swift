//
//  Model.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Model {
    var json: JSON? { get }
    init(object: Any)
    init(json: JSON?)
}

extension Model {
    var statusMessage: String? {
        if let json = json {
            return json["status_message"].string
        }
        return nil
    }
    
    static func createObject<T: Model>(with data: Any?) -> T {
        guard let object = data else {
            return T(object: ["statusMessage": Messages.serverError.localized])
        }
        return T(object: object)
    }
}
