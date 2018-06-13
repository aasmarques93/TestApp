//
//  PagerTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 6/12/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class PagerTests: TestCase {
    // MARK: - Spy Delegate -
    
    class SpyViewModelDelegate: PagerViewDelegate {
        // MARK: Properties
        var didSelectExpectation: XCTestExpectation?
        
        // MARK: Delegate
        func didSelect(at indexPath: IndexPath) {
            didSelectExpectation?.fulfill()
        }
    }
    
    // MARK: - Properties -
    
    private var viewModel: PagerViewModel!
    private var titles = ["Test1", "Test2"]
    
    private var pagerView: PagerView!
    private let delegate = SpyViewModelDelegate()
    
    private var indexPath: IndexPath {
        return IndexPath(item: 0, section: 0)
    }
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        viewModel = PagerViewModel(titles: titles)
        pagerView = instantiate(viewController: PagerView.self, from: .pager)
        pagerView.viewModel = viewModel
        pagerView.reloadData()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        pagerView = nil
    }
    
    // MARK: - Tests -
    
    // MARK: View
    func testSelectItem() {
        pagerView.selectItem(at: indexPath)
        XCTAssertNotNil(pagerView.currentIndexPath)
        
        pagerView.selectItem(at: indexPath, animated: false)
        XCTAssertNotNil(pagerView.currentIndexPath)
    }
    
    func testDidSelectItem() {
        pagerView.delegate = delegate
        delegate.didSelectExpectation = createTestExpectation(message: "Should perform didSelect method")
        pagerView.collectionView(pagerView.collectionView, didSelectItemAt: indexPath)
        
        callWaitForExpectations {
            XCTAssertTrue(self.indexPath.item < self.viewModel.numberOfItems)
            
            self.pagerView.delegate = nil
            self.pagerView.currentIndexPath = self.indexPath
            self.pagerView.collectionView(self.pagerView.collectionView, didSelectItemAt: self.indexPath)
        }
    }
    
    func testChangeFrame() {
        pagerView.selectItem(at: indexPath)
        XCTAssertFalse(pagerView.viewIndicator.frame == .zero)
    }
    
    // MARK: ViewModel
    func testTitle() {
        XCTAssertFalse(viewModel.numberOfItems == 0)
    }
    
    func testFirstItemWidth() {
        XCTAssertNotNil(viewModel.firstItemWidth)
    }
}
