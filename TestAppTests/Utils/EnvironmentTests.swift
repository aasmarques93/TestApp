//
//  EnvironmentTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 8/1/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest
import Moya

@testable import TestApp

class EnvironmentTests: TestCase {
    // MARK: - Properties -
    
    var requestBase: RequestBase!
    var requestBasePost: RequestBase!
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        requestBase = RequestBase(requestUrl: .popular,
                                  environmentBase: .mock,
                                  method: .get,
                                  urlParameters: ["page": 0],
                                  parameters: nil)
        
        requestBasePost = RequestBase(requestUrl: .popular,
                                      environmentBase: .mock,
                                      method: .post,
                                      parameters: ["page": 0])
    }
    
    override func tearDown() {
        super.tearDown()
        requestBase = nil
        requestBasePost = nil
    }
    
    // MARK: - Tests -
    
    func testBaseURL() {
        XCTAssertFalse(requestBase.baseURL.absoluteString == "")
    }
    
    func testPath() {
        XCTAssertFalse(requestBase.path == "")
    }
    
    func testMethod() {
        _ = requestBase.method
    }
    
    func testTask() {
        _ = requestBase.task
        _ = requestBasePost.task
    }
    
    func testSampleData() {
        XCTAssertNotNil(requestBase.sampleData)
    }
    
    func testHeaders() {
        XCTAssertNil(requestBase.headers)
    }
    
    func testRequestUrl() {
        XCTAssertFalse(requestBase.requestUrl.url(environmentBase: .mock) == "")
        XCTAssertFalse(requestBase.requestUrl.url(environmentBase: .mock, parameters: ["id": 0]) == "")
        XCTAssertFalse(requestBase.requestUrl.url(environmentBase: .theMovieDB, parameters: ["id": 0]) == "")
    }
}
