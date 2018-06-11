//
//  TextField.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

extension UITextField {
    private struct AssociatedKeys {
        static var rightInputAccessoryText = "OK"
        static var leftInputAccessoryText = ""
        static var selectedRow = 0
        static var isVerticallyCentered = false
    }
    
    func prepareDateField() {
        leftView = UIImageView(image: #imageLiteral(resourceName: "calendar_range"))
        leftViewMode = .always
        isVerticallyCentered = true
        awakeFromNib()
    }
    
    @IBInspectable var rightInputAccessoryText: String {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKeys.rightInputAccessoryText) as? String else {
                return "OK"
            }
            return object
        }
        set(value) {
            objc_setAssociatedObject(self, &AssociatedKeys.rightInputAccessoryText, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @IBInspectable var leftInputAccessoryText: String {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKeys.leftInputAccessoryText) as? String else {
                return ""
            }
            return object
        }
        set(value) {
            objc_setAssociatedObject(self, &AssociatedKeys.leftInputAccessoryText, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var selectedRow: Int? {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKeys.selectedRow) as? Int else {
                return nil
            }
            return object
        }
        set(value) {
            objc_setAssociatedObject(self, &AssociatedKeys.selectedRow, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder!: "", attributes:[NSAttributedStringKey.foregroundColor: newValue!])
        }
    }
    
    @IBInspectable var sidePadding: CGFloat {
        get {
            return self.sidePadding
        }
        set {
            let padding = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: newValue))
            
            leftViewMode = UITextFieldViewMode.always
            leftView = padding
            
            rightViewMode = UITextFieldViewMode.always
            rightView = padding
        }
    }
    
    @IBInspectable var leftPadding: CGFloat {
        get {
            return self.leftPadding
        }
        set {
            let padding = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: 0))
            
            leftViewMode = UITextFieldViewMode.always
            leftView = padding
        }
    }
    
    @IBInspectable var rightPadding: CGFloat {
        get {
            return self.rightPadding
        }
        set {
            let padding = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: 0))
            
            rightViewMode = UITextFieldViewMode.always
            rightView = padding
        }
    }
    
    @IBInspectable var isVerticallyCentered: Bool {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKeys.isVerticallyCentered) as? Bool else {
                return false
            }
            return object
        }
        set(value) {
            objc_setAssociatedObject(self, &AssociatedKeys.isVerticallyCentered, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    override open func awakeFromNib() {
        if isVerticallyCentered {
            contentVerticalAlignment = .center
        }
    }
}
