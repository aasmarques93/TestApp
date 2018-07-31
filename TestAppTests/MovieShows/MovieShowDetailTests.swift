//
//  MovieShowDetailTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 8/1/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class MovieShowDetailTests: TestCase {
    // MARK: - Spy Delegate -
    
    class SpyViewModelDelegate: MovieShowDetailViewModelDelegate {
        // MARK: Properties
        var reloadDataExpectation: XCTestExpectation?
        var reloadRecommendedMovieShowsExpectation: XCTestExpectation?
        
        // MARK: Delegate
        func reloadData() {
            reloadDataExpectation?.fulfill()
        }
        
        func reloadRecommendedMovieShows() {
            reloadRecommendedMovieShowsExpectation?.fulfill()
        }
    }
    
    // MARK: - Properties -
    
    private var viewModelMovieDetail: MovieShowDetailViewModel!
    private var viewModelShowDetail: MovieShowDetailViewModel!
    private let delegate = SpyViewModelDelegate()
    
    private var movieShowDetailView: MovieShowDetailView!
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        EnvironmentManager.shared.current = .mock
        
        viewModelMovieDetail = MovieShowDetailViewModel(object: createMovie(), isMoviesTab: true)
        viewModelMovieDetail.loadData()
        
        viewModelShowDetail = MovieShowDetailViewModel(object: createShow(), isMoviesTab: false)
        viewModelShowDetail.loadData()
        
        movieShowDetailView = instantiate(viewController: MovieShowDetailView.self, from: .movieShowDetail)
        movieShowDetailView.viewModel = viewModelMovieDetail
    }
    
    override func tearDown() {
        super.tearDown()
        viewModelMovieDetail = nil
        viewModelShowDetail = nil
        movieShowDetailView = nil
    }
    
    // MARK: - Tests -
    
    // MARK: View
    
    func testViewWillAppear() {
        movieShowDetailView.viewWillAppear(true)
        XCTAssertNotNil(movieShowDetailView.viewModel)
        XCTAssertNotNil(movieShowDetailView.title)
    }
    
    func testViewWillAppearFailure() {
        movieShowDetailView.viewModel = viewModelShowDetail
        movieShowDetailView.viewWillAppear(true)
        XCTAssertNotNil(movieShowDetailView.viewModel)
    }
    
    func testScrollViewDidScrollFailure() {
        movieShowDetailView.scrollViewDidScroll(UIScrollView())
        XCTAssertNotNil(movieShowDetailView.stretchHeaderView)
    }
    
    func testShowAlert() {
        movieShowDetailView.showAlert(message: "Test")
        XCTAssertNotNil(movieShowDetailView.alertController)
    }
    
    func testCarouselDidSelectItem() {
        let index = 0
        movieShowDetailView.carousel(movieShowDetailView.carouselRecommendedMovieShows, didSelectItemAt: index)
        XCTAssertNotNil(movieShowDetailView.viewModel?.recommendedMovieShowDetailViewModel(at: index))
    }
    
    // MARK: View Model
    
    func testLoadData() {
        viewModelMovieDetail.delegate = delegate
        delegate.reloadDataExpectation = createTestExpectation()
        delegate.reloadRecommendedMovieShowsExpectation = createTestExpectation(message: "Should perform reloadRecommendedMovieShows()")
        viewModelMovieDetail.loadData()
        callWaitForExpectations {
            if let isDetailEmpty = self.viewModelMovieDetail?.isDetailEmpty {
                XCTAssertFalse(isDetailEmpty)
            }
            XCTAssertFalse(self.viewModelMovieDetail?.numberOfRecommendedMovieShows == 0)
        }
    }
    
    func testLoadDataFailure() {
        viewModelShowDetail.delegate = nil
        viewModelShowDetail.loadData()
        XCTAssertTrue(viewModelShowDetail?.numberOfRecommendedMovieShows == 0)
    }
    
    func testMovieShowDetail() {
        XCTAssertFalse(viewModelMovieDetail.title.value == "")
        XCTAssertFalse(viewModelMovieDetail.average == 0)
        XCTAssertFalse(viewModelMovieDetail.date.value == "")
        XCTAssertFalse(viewModelMovieDetail.runtime.value == "")
        XCTAssertFalse(viewModelMovieDetail.overview.value == "")
    }
    
    func testSetupGenres() {
        XCTAssertFalse(viewModelMovieDetail.genres.value == "")
    }
    
    func testImageUrl() {
        XCTAssertNotNil(viewModelMovieDetail.imageUrl)
    }
    
    func testMovieShowTitle() {
        XCTAssertNotNil(viewModelMovieDetail.movieShowTitle)
        XCTAssertNotNil(viewModelShowDetail.movieShowTitle)
    }
    
    func testMovieShowRecommendedImageUrl() {
        XCTAssertNotNil(viewModelMovieDetail.movieShowRecommendedImageUrl(at: 0))
    }
    
    func testRecommendedMovieShowDetailViewModel() {
        let recommendedMovieShowDetailViewModel = viewModelMovieDetail.recommendedMovieShowDetailViewModel(at: 0)
        XCTAssertNotNil(recommendedMovieShowDetailViewModel)
    }
    
    // MARK: - Objects instantiation -
    
    func createMovie() -> MovieShow {
        let dictionary: [String: Any] = [
            MovieShow.SerializationKeys.id: 299536,
            MovieShow.SerializationKeys.title: "Avengers: Infinity War"
        ]
        return MovieShow(object: dictionary)
    }
    
    func createShow() -> MovieShow {
        let dictionary: [String: Any] = [
            MovieShow.SerializationKeys.id: 1418,
            MovieShow.SerializationKeys.originalName: "The big bang theory"
        ]
        return MovieShow(object: dictionary)
    }
}
