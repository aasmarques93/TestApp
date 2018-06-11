//
//  Extensions.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

//Screen Related Values
var SCREEN_WIDTH: CGFloat {
    return UIScreen.main.bounds.width
    
}
var SCREEN_HEIGHT: CGFloat {
    return AppDelegate.shared.window!.frame.height
}

extension Array {
    func shiftRight(_ amount: Int = 1) -> [Element] {
        var value = amount
        if value < 0 { value += count }
        return Array(self[value ..< count] + self[0 ..< value])
    }
    
    mutating func shiftRightInPlace(amount: Int = 1) {
        self = shiftRight(amount)
    }
    
    mutating func shuffle() {
        for i in (0..<self.count).reversed() {
            let ix1 = i
            let ix2 = Int(arc4random_uniform(UInt32(i+1)))
            (self[ix1], self[ix2]) = (self[ix2], self[ix1])
        }
    }
    
    var shuffled: Array {
        var array = self
        array.shuffle()
        return array
    }
    
    func contains(_ object: AnyObject) -> Bool {
        if self.isEmpty {
            return false
        }
        
        let array = NSArray(array: self)
        return array.contains(object)
    }
    
    func index(of object: AnyObject) -> Int? {
        if self.contains(object) {
            let array = NSArray(array: self)
            return array.index(of: object)
        }
        
        return nil
    }
}
extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController, let selected = tabController.selectedViewController {
            return topViewController(controller: selected)
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing:T.self), for: indexPath) as? T else {
            fatalError("Cant dequeue cell with identifier: \(String(describing:T.self))")
        }
        return cell
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(_: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing:T.self), for: indexPath) as? T else {
            fatalError("Cant dequeue cell with identifier: \(String(describing:T.self))")
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
extension UIView: ReusableIdentifier { }

extension Collection where Index == Int {
    func randomElement() -> Iterator.Element? {
        return isEmpty ? nil : self[Int(arc4random_uniform(UInt32(endIndex)))]
    }
}

extension UIImage {
    func getDataWithProportion(_ heightDesired: Double) -> Data? {
        let proportion = Double(self.size.width) / Double(self.size.height)
        let selectedImage = self.imageResize(sizeChange: CGSize(width: heightDesired * proportion, height: heightDesired))
        guard let imageData: Data = UIImagePNGRepresentation(selectedImage) else {
            return nil
        }
        return imageData
    }
}

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
        static var tab = 0
    }
    
    @IBInspectable var tab: CGFloat {
        get {
            guard let object = objc_getAssociatedObject(self, &AssociatedKeys.tab) as? CGFloat else {
                return 0
            }
            return object
        }
        set(value) {
            objc_setAssociatedObject(self, &AssociatedKeys.tab, value, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

