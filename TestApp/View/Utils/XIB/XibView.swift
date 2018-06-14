//
//  XibView.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/9/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

class XibView: UIView {
    
    // MARK: - Life cycle -
    
    class func instanceFromNib<T: UIView>(_: T.Type) -> T {
        return UINib(nibName: String(describing: T.self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! T
    }
}
