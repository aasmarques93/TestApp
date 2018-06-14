//
//  MovieShowDetailUITests.swift
//  TestAppUITests
//
//  Created by Arthur Augusto Sousa Marques on 6/14/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

class MovieShowDetailUITests: TestAppUITests {
        
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        app.setMainStoryboard("MovieShowDetail")
    }
    
    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Tests -
    
    func testContentView() {
        let query = app.collectionViews
        XCTAssert(query.element.exists)
        
        let cell = query.children(matching: .cell).element(boundBy: 0).children(matching: .other).element(boundBy: 0)
        XCTAssert(cell.exists)
        
        cell.tap()
        cell.swipeUp()
        cell.swipeDown()
    }
}
