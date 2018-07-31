//
//  AppearanceTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 8/1/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class AppearanceTests: TestCase {

    // MARK: - Tests -
    
    func testViewAwakeFromNib() {
        testView(UIView.self, colorStyle: "custom")
        testView(UILabel.self, colorStyle: ColorStyle.text.rawValue)
        testView(UITextField.self, colorStyle: ColorStyle.text.rawValue)
        testView(UITextView.self, colorStyle: ColorStyle.text.rawValue)
        testView(UISegmentedControl.self, colorStyle: ColorStyle.secondary.rawValue)
        testView(UISwitch.self, colorStyle: ColorStyle.secondary.rawValue)
        testView(UIStepper.self, colorStyle: ColorStyle.secondary.rawValue)
        testView(UIProgressView.self, colorStyle: ColorStyle.secondary.rawValue)
        testView(UIActivityIndicatorView.self, colorStyle: ColorStyle.secondary.rawValue)
        testView(UIButton.self, colorStyle: ColorStyle.text.rawValue)
    }
    
    func testView<T: UIView>(_: T.Type, colorStyle: String?) {
        let view = T()
        view.colorStyle = colorStyle
        view.awakeFromNib()
        
        view.colorStyle = nil
        view.awakeFromNib()
        
        XCTAssertNotNil(view)
    }

    func testTextViewDrawRect() {
        let textView = UITextView()
        textView.draw(.zero)
        XCTAssertNotNil(textView)
    }
    
    func testViewCornerRadius() {
        let view = UIView()
        view.cornerRadius = 0
        XCTAssertNotNil(view)
    }
    
    func testStringWidth() {
        let stringWidth = "Test".width
        XCTAssertFalse(stringWidth == 0)
    }
    
    func testStringHeight() {
        let stringHeight = "Test".height
        XCTAssertFalse(stringHeight == 0)
    }
}
