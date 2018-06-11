//
//  ViewModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation

@objc protocol ViewModelDelegate: class {
    @objc optional func reloadData()
    @objc optional func showAlert(message: String?)
}

protocol ViewModel {
}

extension ViewModel {
    func loadData() {
    }
    
    // Create an unwrapped string from any object
    func valueDescription(_ object: Any?) -> String {
        guard let object = object else {
            return ""
        }
        return "\(object)"
    }
    
    // Show error if object has returno status message
    func throwError(with object: Model) throws {
        if let statusMessage = object.statusMessage, statusMessage != "" {
            throw Error(message: statusMessage)
        }
        
        guard let json = object.json else {
            return
        }
        
        let statusMessage = json["status_message"]
        guard let message = statusMessage["message"].string else {
            return
        }
        
        throw Error(message: message)
    }    
}

struct Error: Swift.Error {
    let file: StaticString
    let function: StaticString
    let line: UInt
    let message: String

    init(message: String, file: StaticString = #file, function: StaticString = #function, line: UInt = #line) {
        self.file = file
        self.function = function
        self.line = line
        self.message = message
    }
}
