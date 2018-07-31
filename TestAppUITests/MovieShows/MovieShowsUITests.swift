//
//  MovieShowsUITests.swift
//  TestAppUITests
//
//  Created by Arthur Augusto Sousa Marques on 8/1/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

class MovieShowsUITests: TestAppUITests {
    
    // MARK: - Properties -
    
    private struct Titles {
        static let popular = "Popular"
        static let topRated = "Top Rated"
        static let upcoming = "Upcoming"
        static let nowPlaying = "Now Playing"
    }
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        app.setMainStoryboard("MovieShows")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests -
    
    func testTabs() {
        let collectionViewsQuery = app.collectionViews
        
        testTabSelection(title: Titles.popular, at: collectionViewsQuery)
        testTabSelection(title: Titles.topRated, at: collectionViewsQuery)
        testTabSelection(title: Titles.upcoming, at: collectionViewsQuery)
        testTabSelection(title: Titles.nowPlaying, at: collectionViewsQuery)
    }
    
    func testTabSelection(title: String, at query: XCUIElementQuery) {
        query.cells.otherElements.containing(.staticText, identifier: title).element.swipeLeft()
        query.staticTexts[title].tap()
        XCTAssert(query.staticTexts[title].exists)
    }
    
    func testMovieShowsCollection() {
        let collectionViewsQuery = app.collectionViews.children(matching: .cell)
            .element(boundBy: 1)
            .children(matching: .other)
            .element(boundBy: 0)
        
        collectionViewsQuery.tap()
        collectionViewsQuery.swipeUp()
        XCTAssert(collectionViewsQuery.exists)
    }
}
