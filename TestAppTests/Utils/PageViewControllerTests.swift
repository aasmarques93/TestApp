//
//  PageViewControllerTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 6/12/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class PageViewControllerTests: TestCase {
    // MARK: - Spy Delegate -
    
    class SpyViewModelDelegate: PageViewControllerDelegate {
        // MARK: Properties
        var didFinishAnimatingExpectation: XCTestExpectation?
        
        // MARK: Delegate
        func didFinishAnimating(at indexPath: IndexPath) {
            didFinishAnimatingExpectation?.fulfill()
        }
    }
    
    // MARK: - Properties -
    
    private var pageViewController: PageViewController!
    private let delegate = SpyViewModelDelegate()

    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        pageViewController = instantiate(viewController: PageViewController.self, from: .movieShows)
        pageViewController.viewModel = MovieShowsContainerViewModel(isMoviesTab: true)
    }
    
    override func tearDown() {
        super.tearDown()
        pageViewController = nil
    }
    
    // MARK: - Tests -
    
    func testSetupStartViewController() {
        pageViewController?.setupStartViewController()
        XCTAssertFalse(pageViewController?.viewControllers?.count == 0)
        
        pageViewController?.setupStartViewController(index: 1)
        XCTAssertFalse(pageViewController?.viewControllers?.count == 0)
    }
    
    func testCreateViewController() {
        XCTAssertNotNil(pageViewController?.createViewController(index: 0))
    }
    
    func testPageViewControllerViewControllerBefore() {
        var viewController = pageViewController.pageViewController(pageViewController, viewControllerBefore: pageViewController.createViewController(index: 0))
        XCTAssertNil(viewController)
        
        viewController = pageViewController.pageViewController(pageViewController, viewControllerBefore: pageViewController.createViewController(index: 1))
        XCTAssertNotNil(viewController)
    }
    
    func testPageViewControllerViewControllerAfter() {
        var viewController = pageViewController.pageViewController(pageViewController, viewControllerAfter: pageViewController.createViewController(index: 0))
        XCTAssertNotNil(viewController)
        
        viewController = pageViewController.pageViewController(pageViewController, viewControllerAfter: pageViewController.createViewController(index: 3))
        XCTAssertNil(viewController)
    }

    func testPageViewControllerDidFinishAnimating() {
        pageViewController.pageViewControllerDelegate = delegate
        delegate.didFinishAnimatingExpectation = createTestExpectation(message: "Should perform didFinishAnimating method")
        pageViewController.pageViewController(pageViewController,
                                              didFinishAnimating: true,
                                              previousViewControllers: [],
                                              transitionCompleted: true)
        
        callWaitForExpectations {
            XCTAssertTrue(self.pageViewController.getCurrentPageIndex() == 0)
        }
    }
}
