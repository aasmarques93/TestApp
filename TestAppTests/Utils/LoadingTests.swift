//
//  LoadingTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 6/12/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class LoadingTests: TestCase {
    private var loading: Loading!
    
    override func setUp() {
        super.setUp()
        loading = Loading()
    }
    
    override func tearDown() {
        super.tearDown()
        loading = nil
    }
    
    func testStart() {
        loading.start()
        XCTAssertFalse(loading.hasLoadingError())
    }
    
    func testStartFailure() {
        AppDelegate.shared.window = nil
        loading.start()
        XCTAssertTrue(loading.frame == .zero)
    }
    
    func testStartWithBackgroundColor() {
        loading.start(backgroundColor: UIColor.black)
        XCTAssertFalse(loading.hasLoadingError())
    }
}
