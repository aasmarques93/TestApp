//
//  ExploreUITests.swift
//  TestAppUITests
//
//  Created by Arthur Augusto Sousa Marques on 6/14/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

class ExploreUITests: TestAppUITests {
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        app.setMainStoryboard("Explore")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests -
    
    func testExploreCollection() {
        let collectionViewsQuery = app.collectionViews.children(matching: .cell)
            .element(boundBy: 1)
            .children(matching: .other)
            .element(boundBy: 0)
        
        collectionViewsQuery.tap()
        collectionViewsQuery.swipeUp()
        XCTAssert(collectionViewsQuery.exists)
    }
}
