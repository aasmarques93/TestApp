//
//  FileManagerTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 6/13/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class FileManagerTests: TestCase {
    
    // MARK: - Properties -
    
    var file: String!
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        file = FileManager.load(file: .test, key: "test")
    }
    
    override func tearDown() {
        super.tearDown()
        file = nil
    }
    
    // MARK: - Tests -
    
    func testLoadFileFailure() {
        XCTAssertTrue(file == "")
    }
}
