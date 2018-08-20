//
//  RAMTabBarUtils.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 7/31/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit
import RAMAnimatedTabBarController

extension RAMAnimatedTabBarItem {
    open override func awakeFromNib() {
        super.awakeFromNib()
        textColor = UIColor.lightGray.withAlphaComponent(0.6)
        iconColor = textColor
    }
}

extension RAMItemAnimation {
    open override func awakeFromNib() {
        super.awakeFromNib()
        textSelectedColor = UIColor(colorStyle: .secondary)
        iconSelectedColor = textSelectedColor
    }
}
