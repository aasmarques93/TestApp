//
//  General.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

typealias HandlerGeneric = (_ object: Any?) -> Swift.Void

enum Storyboard: String {
    case main = "Main"
    case movieShows = "MovieShows"
    case movieShowDetail = "MovieShowDetail"
    case explore = "Explore"
    case pager = "Pager"
}

var currentNavigationController: UINavigationController?

func instantiate<T: UIViewController>(viewController: T.Type, from storyboard: Storyboard = .main) -> T {
    let storyboardFile = UIStoryboard(name: storyboard.rawValue, bundle: nil)
    return storyboardFile.instantiateViewController(withIdentifier: viewController.identifier) as! T
}
