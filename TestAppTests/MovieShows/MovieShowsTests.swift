//
//  MovieShowsTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 6/12/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class MovieShowsTests: TestCase {
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
    
    private var viewModel: MovieShowsViewModel!
    private let indexPath = IndexPath(row: 0, section: 0)
    private let delegate = SpyViewModelDelegate()
    private var arrayTabs: [MovieShowTab] {
        var array = [MovieShowTab]()
        array.append(contentsOf: MovieShowTab.movies)
        array.append(contentsOf: MovieShowTab.shows)
        return array
    }
    
    private var movieShowsView: MovieShowsView!
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        EnvironmentManager.shared.current = .mock
        viewModel = MovieShowsViewModel(selectedTab: .popular, isMoviesTab: true)
        viewModel.loadData()
        
        movieShowsView = instantiate(viewController: MovieShowsView.self, from: .movieShow)
        movieShowsView.viewModel = viewModel
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
        movieShowsView = nil
    }
    
    // MARK: - Tests -
    
    // MARK: View
    
    func testShowAlert() {
        movieShowsView.showAlert(message: "Test")
        XCTAssertNotNil(movieShowsView.alertController)
    }
    
    func testDidSelectItem() {
        movieShowsView.collectionView(movieShowsView.collectionView!, didSelectItemAt: indexPath)
        XCTAssertNotNil(movieShowsView.viewModel!.movieShowCellViewModel(at: indexPath))
    }
    
    func testScrollViewDidScroll() {
        movieShowsView.collectionView?.reloadData()
        movieShowsView.scrollViewDidScroll(movieShowsView.collectionView!)
        XCTAssertNotNil(movieShowsView.collectionView!.visibleCells as? [MovieShowViewCell])
    }
    
    func testScrollViewDidScrollFailure() {
        movieShowsView.collectionView = nil
        movieShowsView.scrollViewDidScroll(UIScrollView())
        XCTAssertNil(movieShowsView.collectionView)
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
    
    func testLoadDataFailure() {
        let viewModelFailure = MovieShowsViewModel(selectedTab: .nowPlaying, isMoviesTab: true)
        viewModelFailure.delegate = delegate
        delegate.showAlertExpectation = createTestExpectation(message: "Should perform showAlert")
        viewModelFailure.loadData()
        callWaitForExpectations {
            XCTAssertTrue(viewModelFailure.numberOfItems == 0)
        }
    }
    
    func testLoadDataShows() {
        XCTAssertNotNil(MovieShowsViewModel(selectedTab: .popular, isMoviesTab: false))
    }
    
    func testLoadDataPaginationIfNeeded() {
        viewModel.delegate = delegate
        delegate.reloadDataExpectation = createTestExpectation()
        viewModel.loadDataPaginationIfNeeded(at: IndexPath(row: viewModel.numberOfItems - 2, section: 0))
        callWaitForExpectations {
            XCTAssertFalse(self.viewModel.numberOfItems == 0)
        }
    }
    
    func testMovieShowCellViewModel() {
        let movieShowCellViewModel = viewModel.movieShowCellViewModel(at: indexPath)!

        XCTAssertNotNil(movieShowCellViewModel)
        XCTAssertNotNil(movieShowCellViewModel.imagePathUrl)
        
        XCTAssertFalse(movieShowCellViewModel.title.value == "")
        XCTAssertFalse(movieShowCellViewModel.average.value == "")
    }
    
    func testMovieShowCellViewModelFailure() {
        let movieShowCellViewModel = viewModel.movieShowCellViewModel(at: IndexPath(row: 100, section: 0))
        XCTAssertNil(movieShowCellViewModel)
    }
    
    func testMovieShowDetailViewModel() {
        let movieShowDetailViewModel = viewModel.movieShowDetailViewModel(at: indexPath)
        XCTAssertNotNil(movieShowDetailViewModel)
    }
    
    func testMovieShowDetailViewModelFailure() {
        let movieShowDetailViewModel = viewModel.movieShowDetailViewModel(at: IndexPath(row: 100, section: 0))
        XCTAssertNil(movieShowDetailViewModel)
    }
    
    func testMovieShowTabsEnum() {
        arrayTabs.forEach { (tab) in
            testMovieShowTab(tab, requestUrl: tab.requestUrl)
        }
    }
    
    func testMovieShowTab(_ tab: MovieShowTab, requestUrl: RequestUrl) {
        XCTAssertTrue(tab.requestUrl == requestUrl)
    }
}
