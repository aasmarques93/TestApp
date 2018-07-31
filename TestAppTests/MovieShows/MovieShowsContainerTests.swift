//
//  MovieShowsContainerTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 8/1/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class MovieShowsContainerTests: TestCase {
    // MARK: - Properties -
    
    private var viewModelMovies: MovieShowsContainerViewModel?
    private var viewModelShows: MovieShowsContainerViewModel?
    
    private var movieShowsContainerView: MovieShowsContainerView?
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        viewModelMovies = MovieShowsContainerViewModel(isMoviesTab: true)
        viewModelShows = MovieShowsContainerViewModel(isMoviesTab: false)
        movieShowsContainerView = instantiate(viewController: MovieShowsContainerView.self, from: .movieShows)
        movieShowsContainerView?.viewModel = viewModelMovies
        movieShowsContainerView?.setupPagerView()
        movieShowsContainerView?.setupPageViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModelMovies = nil
        viewModelShows = nil
        movieShowsContainerView = nil
    }
    
    // MARK: - Tests -
    
    // MARK: View
    
    func testSetupAppearance() {
        movieShowsContainerView?.navigationController?.tabIndex = 0
        movieShowsContainerView?.setupAppearance()
        XCTAssertNotNil(movieShowsContainerView?.navigationItem.titleView)

        movieShowsContainerView?.navigationController?.tabIndex = 1
        movieShowsContainerView?.setupAppearance()
        XCTAssertNotNil(movieShowsContainerView?.navigationItem.titleView)
    }
    
    func testDidSelectPagerItem() {
        movieShowsContainerView?.didSelect(at: IndexPath(item: 0, section: 0))
        XCTAssertNotNil(movieShowsContainerView?.pageViewController?.viewControllers)
    }
    
    func testDidFinishAnimating() {
        movieShowsContainerView?.didFinishAnimating(at: IndexPath(item: 0, section: 0))
        XCTAssertNotNil(movieShowsContainerView?.pagerView)
    }
    
    // MARK: View Model
    
    func testInitialization() {
        XCTAssertFalse(viewModelMovies?.numberOfTabs == 0)
        XCTAssertFalse(viewModelShows?.numberOfTabs == 0)
    }
    
    func testMovieShowsViewModel() {
        let movieShowsViewModel = viewModelMovies?.movieShowsViewModel(at: 0)
        XCTAssertNotNil(movieShowsViewModel)
    }
    
    func testPagerViewModel() {
        let pagerViewModel = viewModelMovies?.pagerViewModel()
        XCTAssertNotNil(pagerViewModel)
    }
}
