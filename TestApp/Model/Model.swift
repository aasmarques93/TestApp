//
//  Model.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 7/31/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol Model {
    init(object: Any?)
    init(json: JSON)
    var json: JSON { get }
    var statusMessage: String? { get set }
    var dictionaryRepresentation: [String: Any] { get }
}

private let statusMessageKey = "status_message"

extension Model {
    mutating func handleStatusMessageError() {
        statusMessage = json[statusMessageKey].string
    }
}

func createModelErrorData(message: String = Messages.serverError.localized) -> [String: Any] {
    return [statusMessageKey: message]
}
