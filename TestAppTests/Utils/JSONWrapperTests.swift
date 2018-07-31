//
//  JSONWrapperTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 8/1/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class JSONWrapperTests: TestCase {
    
    // MARK: - Tests -

    func testJsonFromResource() {
        JSONWrapper.json(from: .popular)
        JSONWrapper.json(from: .test)
    }
    
    func testObjectFromResource() {
        XCTAssertNotNil(JSONWrapper.object(from: .popular))
        XCTAssertNil(JSONWrapper.object(from: .test))
    }
}
