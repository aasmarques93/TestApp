//
//  ModelTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 6/12/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class ModelTests: XCTestCase {
    
    // MARK: - Tests -
    
    func testInitialization() {
        testObject(MovieShowsList.self, requestUrl: .popular)
        testObject(MovieShow.self, requestUrl: .movie)
        testObject(MovieShowDetail.self, requestUrl: .movie)
        testObject(GenresList.self, requestUrl: .genres)
        testObject(Genre.self, requestUrl: .genre)
    }
    
    func testObject<T: Model>(_: T.Type, requestUrl: RequestUrl) {
        let object = JSONWrapper.object(from: requestUrl)
        let mockObject = T(object: object!)
        XCTAssertNil(mockObject.statusMessage)
        XCTAssertFalse(mockObject.dictionaryRepresentation().count == 0)
        
        let failureObject = T(object: nil)
        XCTAssertNotNil(failureObject.statusMessage)
    }
}
