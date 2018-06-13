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
    init(object: Any?)
    init(json: JSON)
    var json: JSON { get }
    func dictionaryRepresentation() -> [String: Any]
}

extension Model {
    var statusMessage: String? {
        return json["status_message"].string
    }
    
    static var dictionaryErrorData: [String: Any] {
        return ["status_message": Messages.serverError.localized]
    }
}
