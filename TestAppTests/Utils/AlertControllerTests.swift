//
//  AlertControllerTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 8/1/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class AlertControllerTests: TestCase {
    // MARK: - Properties -
    
    var viewController: UIViewController!
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        viewController = UIViewController()
    }
    
    override func tearDown() {
        super.tearDown()
        viewController = nil
    }
    
    // MARK: - Tests -
    
    func testShowAlert() {
        viewController.alertController?.show(message: "Test Error")
        viewController.alertController?.show(message: "Test Success", type: .success)
        
        let doneExpectation = createTestExpectation(message: "should perfome done action")
        viewController.alertController?.show(title: "Test Tile",
                                             message: "Test Message",
                                             buttonText: "Test",
                                             buttonAction: {
            
                                                doneExpectation.fulfill()
        }, callActionsAutomatically: true)
        
        callWaitForExpectations {
            XCTAssertNotNil(self.viewController.alertController)
        }
    }
}
