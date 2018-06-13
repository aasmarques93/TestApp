//
//  CircularProgressViewTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 6/13/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class CircularProgressViewTests: TestCase {
    
    // MARK: Properties
    
    var circularProgressView: CircularProgressView!
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        circularProgressView = CircularProgressView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    override func tearDown() {
        super.tearDown()
        circularProgressView = nil
    }
    
    // MARK: - Tests -
    
    func testInitialization() {
        AppDelegate.shared.window?.addSubview(circularProgressView)
        circularProgressView.setNeedsDisplay()
        
        XCTAssertNotNil(circularProgressView)

        circularProgressView.progress = 1.0
        XCTAssertFalse(circularProgressView.progress == 0)
        
        circularProgressView.setCircleStrokeWidth(1.0)
        XCTAssertFalse(circularProgressView.circleStrokeWidth == 0)
        
        circularProgressView.setCircleStrokeColor(UIColor.black)
        XCTAssertTrue(circularProgressView.circleStrokeColor == UIColor.black)
    }
}
