//
//  ViewModelTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 6/13/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class ViewModelTests: XCTestCase {
    
    // MARK: - Properties -
    
    struct MockViewModel: ViewModel {
    }
    
    var viewModel: MockViewModel!
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        viewModel = MockViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    // MARK: - Tests -
    
    func testLoadData() {
        viewModel.loadData()
        XCTAssertNotNil(viewModel)
    }
    
    func testThrowError() {
        let object = MovieShow(object: ["id": 0])
        try? viewModel.throwError(with: object)
        XCTAssertNotNil(object)
        
        let errorObject = MovieShow(object: ["status_message": "error"])
        try? viewModel.throwError(with: errorObject)
        XCTAssertNotNil(errorObject)
    }
}
