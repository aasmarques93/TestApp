//
//  Appearance.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

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

extension UIImage {
    func imageResize(sizeChange: CGSize) -> UIImage {
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        self.draw(in: CGRect(origin: CGPoint.zero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage!
    }
}

extension CAGradientLayer {
    convenience init(frame: CGRect, colors: [UIColor]) {
        self.init()
        self.frame = frame
        self.colors = []
        colors.forEach { (color) in
            self.colors?.append(color.cgColor)
        }
        startPoint = CGPoint(x: 0, y: 0)
        endPoint = CGPoint(x: 1, y: 0)
    }
    
    func creatGradientImage() -> UIImage? {
        var image: UIImage? = nil
        UIGraphicsBeginImageContext(bounds.size)
        if let context = UIGraphicsGetCurrentContext() {
            render(in: context)
            image = UIGraphicsGetImageFromCurrentImageContext()
        }
        UIGraphicsEndImageContext()
        return image
    }
}

extension UITabBarController {
    open override func awakeFromNib() {
        tabBar.tintColor = UIColor(colorStyle: .primary)
    }
}

typealias GradientPoints = (startPoint: CGPoint, endPoint: CGPoint)

enum GradientOrientation {
    case topRightBottomLeft
    case topLeftBottomRight
    case horizontal
    case vertical
    
    var startPoint: CGPoint {
        return points.startPoint
    }
    
    var endPoint: CGPoint {
        return points.endPoint
    }
    
    var points: GradientPoints {
        get {
            switch(self) {
            case .topRightBottomLeft:
                return (CGPoint(x: 0.0,y: 1.0), CGPoint(x: 1.0,y: 0.0))
            case .topLeftBottomRight:
                return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 1,y: 1))
            case .horizontal:
                return (CGPoint(x: 0.0,y: 0.5), CGPoint(x: 1.0,y: 0.5))
            case .vertical:
                return (CGPoint(x: 0.0,y: 0.0), CGPoint(x: 0.0,y: 1.0))
            }
        }
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
            textField.placeHolderColor = UIColor(colorStyle: style ?? .text)
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
    
    func applyGradient(colors: [UIColor], orientation: GradientOrientation = .horizontal) -> Void {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        gradient.colors = colors.map { $0.cgColor }
        gradient.startPoint = orientation.startPoint
        gradient.endPoint = orientation.endPoint
        layer.insertSublayer(gradient, at: 0)
    }
    
    func removeGradient() {
        guard let sublayers = layer.sublayers else {
            return
        }
        sublayers.forEach { (sublayer) in
            sublayer.removeFromSuperlayer()
        }
    }
}

class GradientView: UIView {
    @IBInspectable var startColor: UIColor = .black { didSet { updateColors() } }
    @IBInspectable var endColor: UIColor = .white { didSet { updateColors() } }
    @IBInspectable var startLocation: Double = 0.05 { didSet { updateLocations() } }
    @IBInspectable var endLocation: Double = 0.95 { didSet { updateLocations() } }
    @IBInspectable var horizontalMode: Bool = false { didSet { updatePoints() } }
    @IBInspectable var diagonalMode: Bool = false { didSet { updatePoints() } }
    
    override class var layerClass: AnyClass { return CAGradientLayer.self }
    
    var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
    
    func updatePoints() {
        if horizontalMode {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0): CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = diagonalMode ? CGPoint(x: 0, y: 1): CGPoint(x: 1, y: 0.5)
        } else {
            gradientLayer.startPoint = diagonalMode ? CGPoint(x: 0, y: 0): CGPoint(x: 0.5, y: 0)
            gradientLayer.endPoint = diagonalMode ? CGPoint(x: 1, y: 1): CGPoint(x: 0.5, y: 1)
        }
    }
    func updateLocations() {
        gradientLayer.locations = [startLocation as NSNumber, endLocation as NSNumber]
    }
    func updateColors() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updatePoints()
        updateLocations()
        updateColors()
    }
}

extension UISearchBar {
    @IBInspectable var textColor: UIColor? {
        get {
            if let textField = self.value(forKey: "searchField") as? UITextField  {
                return textField.textColor
            } else {
                return nil
            }
        }
        
        set (newValue) {
            if let textField = self.value(forKey: "searchField") as? UITextField  {
                textField.textColor = newValue
            }
        }
    }
}

extension UITextView {
    open override func draw(_ rect: CGRect) {
        super.draw(rect)
        scrollRangeToVisible(NSMakeRange(0, 0))
    }
}

extension UIView {
    @IBInspectable var shadowColor: UIColor? {
        set {
            layer.shadowColor = newValue!.cgColor
        }
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor:color)
            }
            else {
                return nil
            }
        }
    }
    
    @IBInspectable var shadowOpacity: Float {
        set {
            layer.shadowOpacity = newValue
        }
        get {
            return layer.shadowOpacity
        }
    }
    
    @IBInspectable var shadowOffset: CGPoint {
        set {
            layer.shadowOffset = CGSize(width: newValue.x, height: newValue.y)
        }
        get {
            return CGPoint(x: layer.shadowOffset.width, y:layer.shadowOffset.height)
        }
    }
    
    @IBInspectable var shadowRadius: CGFloat {
        set {
            layer.shadowRadius = newValue
        }
        get {
            return layer.shadowRadius
        }
    }
    
    @IBInspectable var borderColor: UIColor {
        get {
            return self.borderColor
        }
        set {
            layer.masksToBounds = true
            layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.borderWidth
        }
        set {
            layer.masksToBounds = true
            layer.borderWidth = newValue
        }
    }
    
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
