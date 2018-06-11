//
//  String.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

extension String {
    func formatCurrency(range: NSRange, string: String) -> String {
        let oldText = self as NSString
        let newText = oldText.replacingCharacters(in: range, with: string)
        var newTextString = newText
        
        let digits = NSCharacterSet.decimalDigits
        var digitText = ""
        for c in newTextString.unicodeScalars {
            if digits.contains(c) {
                digitText += "\(c)"
            }
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.currency
        formatter.locale = Locale.current
        
        let numberFromField = (NSString(string: digitText).doubleValue)/100
        if let formattedText = formatter.string(for: numberFromField) {
            return formattedText
        }
        return ""
    }
    
    var jsonObject: Any? {
        if let data = self.data(using: .utf8) {
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                return object
            } catch { }
        }
        return nil
    }
    
    var isEmptyOrWhitespace: Bool {
        if self.isEmpty || self == "" { return true }
        return self.trimmingCharacters(in: CharacterSet.whitespaces) == ""
    }
    
    func insert(_ string: String, at index: Int) -> String {
        return String(prefix(index)) + string + String(suffix(count - index))
    }
    
    var onlyNumbers: String {
        return replacingOccurrences(of: "[^0-9]", with: "", options: String.CompareOptions.regularExpression, range: nil)
    }
    
    var width: CGFloat {
        get {
            let label = UILabel()
            label.text = self
            label.sizeToFit()
            
            if label.frame.width < 50 { return 50 }
            return label.frame.width
        }
        set { }
    }
    
    var height: CGFloat {
        get {
            guard let keyWindow = UIApplication.shared.keyWindow else {
                return 0
            }
            
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: keyWindow.frame.size.width, height: 40))
            label.numberOfLines = 1000
            label.text = self
            label.sizeToFit()
            return label.frame.height
        }
        set { }
    }
}
