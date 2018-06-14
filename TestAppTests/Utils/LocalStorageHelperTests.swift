//
//  LocalStorageHelperTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 6/13/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class LocalStorageHelperTests: TestCase {
    
    // MARK: - Properties -
    
    var requestUrl: RequestUrl!
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        requestUrl = .searchByGenre
    }
    
    override func tearDown() {
        super.tearDown()
        requestUrl = nil
    }
    
    // MARK: - Tests -
    
    func testSave() {
        XCTAssertTrue(LocalStorageHelper.save(object: ["id": 0], requestUrl: requestUrl))
    }
    
    func testSaveFailure() {
        XCTAssertFalse(LocalStorageHelper.save(object: nil, requestUrl: requestUrl))
    }
    
    func testDelete() {
        _ = LocalStorageHelper.delete(requestUrl: requestUrl)
        XCTAssertNil(LocalStorageHelper.fetch(requestUrl: requestUrl))
    }
}
