//
//  LoadingView.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/11/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

private let margin: CGFloat = 16
private let activityHeight: CGFloat = 40
private let alphaBackground: CGFloat = 0.7
private let fontSize: CGFloat = 14

fileprivate class LoadingView: UIView {
    private var activityIndicator: NVActivityIndicatorView {
        let type = NVActivityIndicatorType(rawValue: Int.random(lower: 0, upper: 32))
        let activityIndicator = NVActivityIndicatorView(frame: CGRect(x: 0, y: margin, width: activityHeight, height: activityHeight),
                                                        type: type)
        
        activityIndicator.center = CGPoint(x: self.center.x, y: self.center.y)
        activityIndicator.color = HexColor.secondary.color
        activityIndicator.startAnimating()
        
        return activityIndicator
    }

    init(frame: CGRect = .zero, backgroundColor: UIColor? = nil) {
        super.init(frame: frame)
        self.backgroundColor = backgroundColor ?? HexColor.primary.color.withAlphaComponent(alphaBackground)
        self.addSubview(activityIndicator)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startInWindow() {
        guard let window = AppDelegate.shared.window else {
            return
        }
        window.addSubview(self)
    }
    
    func stop() {
        removeFromSuperview()
    }
}

protocol LoadingProtocol {
    var loading: Loading { get set }
}

struct Loading {
    fileprivate var loadingView: LoadingView?
    
    mutating func start(backgroundColor: UIColor? = nil) {
        loadingView = LoadingView(frame: AppDelegate.shared.window?.frame ?? .zero,
                                  backgroundColor: backgroundColor)
        loadingView?.startInWindow()
    }
    
    func stop() {
        loadingView?.stop()
    }
}
