//
//  ColorStyle.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

enum ColorStyle: String {
    case primary
    case secondary
    case tertiary
    case accent
    case text
    
    var color: UIColor {
        switch self {
        case .primary:
            return #colorLiteral(red: 0.03137254902, green: 0.1098039216, blue: 0.1411764706, alpha: 1)
        case .secondary:
            return #colorLiteral(red: 0.003921568627, green: 0.8235294118, blue: 0.4666666667, alpha: 1)
        case .tertiary:
            return #colorLiteral(red: 0.01568627451, green: 0.5019607843, blue: 0.3176470588, alpha: 1)
        case .accent:
            return #colorLiteral(red: 0.9450980392, green: 0.3725490196, blue: 0.3137254902, alpha: 1)
        case .text:
            return #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        }
    }
}

extension UIColor {
    convenience init(colorStyle: ColorStyle?) {
        self.init(hexString: colorStyle?.color.toHexString ?? ColorStyle.primary.color.toHexString)
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    var toHexString: String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
}
