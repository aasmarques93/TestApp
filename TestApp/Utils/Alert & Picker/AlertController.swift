//
//  AlertController.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 7/31/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit
import FCAlertView

typealias AlertHandler = () -> Void

enum AlertType {
    case error
    case success
}

extension UIViewController {
    var alertController: UIAlertController? {
        return UIAlertController(style: .alert)
    }
}

extension UIAlertController {
    convenience init(title: String? = nil,
                     message: String? = nil,
                     style: UIAlertControllerStyle) {
        
        self.init(title: title, message: message, preferredStyle: style)
    }
    
    func show(title: String? = nil,
              message: String?,
              type: AlertType = .error,
              buttonText: String? = nil,
              buttonAction: AlertHandler? = nil,
              callActionsAutomatically: Bool = false) {
        
        let alertView = FCAlertView()
        alertView.colorScheme = type == .error ? UIColor(colorStyle: .accent) : UIColor(colorStyle: .secondary)
        alertView.titleColor = UIColor(colorStyle: .primary)
        
        alertView.doneActionBlock {
            buttonAction?()
        }
        
        if callActionsAutomatically {
            alertView.doneBlock()
        }
        
        var alertTitle = title
        if alertTitle == nil {
            alertTitle = type == .error ? Titles.error.localized : Titles.success.localized
        }
        
        alertView.showAlert(withTitle: alertTitle!,
                            withSubtitle: message,
                            withCustomImage: #imageLiteral(resourceName: "logo"),
                            withDoneButtonTitle: buttonText ?? Titles.done.localized,
                            andButtons: nil)
    }
}
