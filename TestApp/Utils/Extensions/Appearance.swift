//
//  Appearance.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

var SCREEN_WIDTH: CGFloat {
    return UIScreen.main.bounds.width
}
var SCREEN_HEIGHT: CGFloat {
    return AppDelegate.shared.window!.frame.height
}

extension UINavigationController {
    open override func awakeFromNib() {
        navigationBar.barTintColor = UIColor(colorStyle: .primary)
        navigationBar.tintColor = UIColor(colorStyle: .secondary)
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: navigationBar.tintColor]
        navigationBar.isTranslucent = false
        navigationBar.isOpaque = true
        navigationBar.shadowImage = UIImage()
        
        currentNavigationController = self
    }
}

extension UIViewController {
    open override func awakeFromNib() {
        view.backgroundColor = UIColor(colorStyle: .primary)
    }
    
    func setTitleView(text: String) {
        let labelTitle = UILabel()
        labelTitle.text = text
        labelTitle.textColor = navigationController?.navigationBar.tintColor
        labelTitle.font = UIFont.boldSystemFont(ofSize: 17)
        labelTitle.sizeToFit()
        navigationItem.titleView = labelTitle
    }
}

extension UITabBar {
    open override func awakeFromNib() {
        isTranslucent = false
        barTintColor = UIColor(colorStyle: .primary)
        tintColor = UIColor(colorStyle: .secondary)
    }
}

extension UITabBarController {
    open override func awakeFromNib() {
        tabBar.tintColor = UIColor(colorStyle: .primary)
    }
}

extension UIView {
    private struct AssociatedKeys {
        static var colorStyle = ""
    }
    
    @IBInspectable var colorStyle: String? {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKeys.colorStyle) as? String else {
                return nil
            }
            return object
        }
        set(value) {
            objc_setAssociatedObject(self, &AssociatedKeys.colorStyle, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        guard colorStyle != "custom" else {
            return
        }
        
        let style = ColorStyle(rawValue: colorStyle ?? "")
        
        if let label = self as? UILabel {
            label.textColor = UIColor(colorStyle: style ?? .text)
            return
        }
        if let textField = self as? UITextField {
            textField.textColor = UIColor(colorStyle: style ?? .text)
            return
        }
        if let textView = self as? UITextView {
            textView.textColor = UIColor(colorStyle: style ?? .text)
            return
        }
        if let segmentedControl = self as? UISegmentedControl {
            segmentedControl.tintColor = UIColor(colorStyle: style ?? .secondary)
            return
        }
        if let switchValue = self as? UISwitch {
            switchValue.onTintColor = UIColor(colorStyle: style ?? .secondary)
            return
        }
        if let stepper = self as? UIStepper {
            stepper.tintColor = UIColor(colorStyle: style ?? .secondary)
            return
        }
        if let progressView = self as? UIProgressView {
            progressView.progressTintColor = UIColor(colorStyle: style ?? .secondary)
            return
        }
        if let activityIndicator = self as? UIActivityIndicatorView {
            activityIndicator.color = UIColor(colorStyle: style ?? .secondary)
            return
        }
        if let button = self as? UIButton {
            button.setTitleColor(UIColor(colorStyle: style ?? .text), for: .normal)
            button.tintColor = UIColor(colorStyle: style ?? .text)
            return
        }
        
        guard let color = style else {
            return
        }
        self.backgroundColor = UIColor(colorStyle: color)
    }
}

extension UITextView {
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        scrollRangeToVisible(NSMakeRange(0, 0))
    }
}

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = newValue
        }
    }
}

extension String {
    var width: CGFloat {
        let label = UILabel()
        label.text = self
        label.sizeToFit()
        
        if label.frame.width < 50 { return 50 }
        return label.frame.width
    }
    
    var height: CGFloat {
        guard let keyWindow = UIApplication.shared.keyWindow else {
            return 0
        }
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: keyWindow.frame.size.width, height: 40))
        label.numberOfLines = 1000
        label.text = self
        label.sizeToFit()
        return label.frame.height
    }
}
