//
//  ExploreTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 8/1/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class ExploreTests: TestCase {
    // MARK: - Spy Delegate -
    
    class SpyViewModelDelegate: ViewModelDelegate {
        // MARK: Properties
        var reloadDataExpectation: XCTestExpectation?
        var showAlertExpectation: XCTestExpectation?
        
        // MARK: Delegate
        func reloadData() {
            reloadDataExpectation?.fulfill()
        }
        
        func showAlert(message: String?) {
            showAlertExpectation?.fulfill()
        }
    }
    
    // MARK: - Properties -
    
    private var viewModel: ExploreViewModel!
    private let indexPath = IndexPath(item: 0, section: 0)
    private let delegate = SpyViewModelDelegate()
    private var exploreView: ExploreView!
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        EnvironmentManager.shared.current = .mock
        viewModel = ExploreViewModel()
        viewModel.loadData()
        
        exploreView = instantiate(viewController: ExploreView.self, from: .explore)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        exploreView = nil
    }

    // MARK: - Tests -
    
    // MARK: View
    
    func testViewWillAppear() {
        exploreView.viewWillAppear(true)
        XCTAssertNotNil(exploreView.collectionView)
    }
    
    func testDidSelectItem() {
        exploreView.collectionView?.reloadData()
        exploreView.collectionView(exploreView.collectionView!, didSelectItemAt: indexPath)
        XCTAssertNotNil(exploreView.viewModel.exploreCellViewModel(at: indexPath))
    }
    
    // MARK: View Model
    
    func testLoadData() {
        viewModel.delegate = delegate
        delegate.reloadDataExpectation = createTestExpectation()
        viewModel.loadData()
        callWaitForExpectations {
            XCTAssertFalse(self.viewModel.numberOfItems == 0)
        }
    }
    
    func testExploreCellViewModel() {
        let exploreCellViewModel = viewModel.exploreCellViewModel(at: indexPath)
        
        XCTAssertNotNil(exploreCellViewModel)
        XCTAssertNotNil(exploreCellViewModel.genre)
    }
    
    func testMovieShowsViewModel() {
        let movieShowsViewModel = viewModel.movieShowsViewModel(at: indexPath)
        XCTAssertNotNil(movieShowsViewModel)
    }
}
