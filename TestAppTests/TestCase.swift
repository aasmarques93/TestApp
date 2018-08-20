//
//  TestCase.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 8/1/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class TestCase: XCTestCase {
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    // MARK: - Tests -
    
    func createTestExpectation(message: String = "Should perform reloadData()") -> XCTestExpectation {
        let testExpectation = expectation(description: message)
        return testExpectation
    }
    
    func callWaitForExpectations(handler: @escaping HandlerCallback) {
        waitForExpectations(timeout: 1) { (error) in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
            handler()
        }
    }
}
