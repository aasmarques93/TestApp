//
//  LottieHelper.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit
import Lottie

enum LottieType: String {
    case boat = "Boat_Loader"
}

struct LottieHelper {
    static func createAnimationView(frame: CGRect,
                                    type: LottieType,
                                    contentMode: UIViewContentMode = .scaleAspectFill,
                                    loopAnimation: Bool = true) -> LOTAnimationView {
        
        let animationView = LOTAnimationView(name: type.rawValue)
        animationView.contentMode = contentMode
        animationView.frame = frame
        animationView.loopAnimation = loopAnimation
        
        return animationView
    }
}
