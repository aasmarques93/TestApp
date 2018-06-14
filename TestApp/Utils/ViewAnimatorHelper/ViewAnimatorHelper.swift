//
//  ViewAnimatorHelper.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/14/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit
import ViewAnimator

enum AnimatorType {
    case from
    case rotate
    case zoom
}

struct ViewAnimatorHelper {
    static func animate(views: [UIView?]?,
                        type: AnimatorType = .from,
                        direction: Direction = .right,
                        offset: CGFloat = 30,
                        angle: CGFloat = 360,
                        scale: CGFloat = 100) {
        
        guard let views = views else {
            return
        }
        
        var animations = [AnimationType]()
        
        switch type {
        case .from:
            animations.append(AnimationType.from(direction: direction, offset: offset))
        case .rotate:
            animations.append(AnimationType.rotate(angle: angle))
        case .zoom:
            animations.append(AnimationType.zoom(scale: scale))
        }
        
        UIView.animate(views: views.map { $0 ?? UIView() }, animations: animations)
    }
}
