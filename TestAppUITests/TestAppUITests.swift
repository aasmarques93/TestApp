//
//  TestAppUITests.swift
//  TestAppUITests
//
//  Created by Arthur Augusto Sousa Marques on 6/8/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

class TestAppUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        setupApp()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    private func setupApp() {
        app = XCUIApplication()
        app.useMock()
        app.launch()
    }
    
    func testAppOrientation() {
        XCUIDevice.shared.orientation = .portrait
        XCTAssertNotNil(XCUIDevice.shared.orientation)
    }
    
    func testNavigationBar() {
        let navigationBar = app.navigationBars.element(boundBy: 0)
        XCTAssert(navigationBar.exists)
    }
}

extension XCUIApplication {
    func useMock() {
        self.launchArguments.append("mock")
    }
    
    func setMainStoryboard(_ identifier: String) {
        self.launchEnvironment["mainInterface"] = identifier
    }
}
