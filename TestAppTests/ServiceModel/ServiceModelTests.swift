//
//  ServiceModelTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 6/12/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class ServiceModelTests: XCTestCase {
    
    // MARK: - Properties -
    
    struct MockServiceModel: ServiceModel {
    }
    
    var serviceModel: MockServiceModel!
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        serviceModel = MockServiceModel()
    }
    
    override func tearDown() {
        super.tearDown()
        serviceModel = nil
    }
    
    // MARK: - Tests -
    
    func testHandleJsonResponse() {
        let object = serviceModel.handleJsonResponse(json: ["id": 0])
        XCTAssertNotNil(object)
        
        let array = serviceModel.handleJsonResponse(json: [["id": 0], ["id": 1]])
        XCTAssertNotNil(array)
    }
}
