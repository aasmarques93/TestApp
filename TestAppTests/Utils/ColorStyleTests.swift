//
//  ColorStyleTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 6/12/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class ColorStyleTests: TestCase {
    
    // MARK: - Tests -
    
    func testColors() {
        XCTAssertEqual(#colorLiteral(red: 0.03137254902, green: 0.1098039216, blue: 0.1411764706, alpha: 1), ColorStyle.primary.color)
        XCTAssertEqual(#colorLiteral(red: 0.003921568627, green: 0.8235294118, blue: 0.4666666667, alpha: 1), ColorStyle.secondary.color)
        XCTAssertEqual(#colorLiteral(red: 0.01568627451, green: 0.5019607843, blue: 0.3176470588, alpha: 1), ColorStyle.tertiary.color)
        XCTAssertEqual(#colorLiteral(red: 0.9450980392, green: 0.3725490196, blue: 0.3137254902, alpha: 1), ColorStyle.accent.color)
        XCTAssertEqual(#colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1), ColorStyle.text.color)
    }
    
    func testInitialization() {
        let color = UIColor(colorStyle: nil)
        XCTAssertNotNil(color)
        
        let hexColor = UIColor(hexString: "FFFFFF")
        XCTAssertNotNil(hexColor)
    }
}
