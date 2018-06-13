//
//  Extensions.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController, let selected = tabController.selectedViewController {
            return topViewController(controller: selected)
        }
        return controller
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Cant dequeue cell with identifier: \(String(describing: T.self))")
        }
        return cell
    }
}

protocol ReusableIdentifier: class { }
extension ReusableIdentifier where Self: UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}
extension UIViewController: ReusableIdentifier { }

extension Int {
    static func random(lower: Int, upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}

extension UIViewController {
    private struct AssociatedKeys {
        static var pageIndex = 0
    }
    
    var pageIndex: Int? {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKeys.pageIndex) as? Int else {
                return nil
            }
            return object
        }
        set(value) {
            objc_setAssociatedObject(self, &AssociatedKeys.pageIndex, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension UIPageViewController {
    func getCurrentPageIndex() -> Int {
        guard let currentViewController = self.viewControllers?.first, let index = currentViewController.pageIndex else {
            return 0
        }
        return index
    }
}

extension UINavigationController {
    private struct AssociatedKeys {
        static var tabIndex = 0
    }
    
    @IBInspectable var tabIndex: CGFloat {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKeys.tabIndex) as? CGFloat else {
                return 0
            }
            return object
        }
        set(value) {
            objc_setAssociatedObject(self, &AssociatedKeys.tabIndex, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

