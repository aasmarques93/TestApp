//
//  ExtensionsTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 6/12/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class ExtensionsTests: TestCase {
    // MARK: - Properties -
    
    var viewController: UIViewController!
    var navigationController: UINavigationController!
    var pageViewController: UIPageViewController!
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        viewController = UIViewController()
        navigationController = UINavigationController(rootViewController: viewController)
        pageViewController = UIPageViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        viewController = nil
        navigationController = nil
        pageViewController = nil
    }
    
    // MARK: - Tests -

    func testTopViewController() {
        XCTAssertNotNil(UIApplication.topViewController(controller: navigationController))
        XCTAssertNotNil(UIApplication.topViewController(controller: UIViewController()))
        XCTAssertNotNil(UIApplication.topViewController(controller: UITabBarController()))
        XCTAssertNotNil(UIApplication.topViewController())
    }
    
    func testPageIndex() {
        viewController.pageIndex = 0
        XCTAssertNotNil(viewController.pageIndex)
    }
    
    func testTabIndex() {
        navigationController.tabIndex = 0
        XCTAssertNotNil(navigationController.tabIndex)
    }
    
    func testGetCurrentPageIndex() {
        XCTAssertTrue(pageViewController.getCurrentPageIndex() == 0)
        
        viewController.pageIndex = 1
        pageViewController.setViewControllers([viewController], direction: .forward, animated: true, completion: nil)
        XCTAssertTrue(pageViewController.getCurrentPageIndex() == 1)
    }
}
