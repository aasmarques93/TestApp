//
//  ViewAnimatorHelperTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 6/14/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class ViewAnimatorHelperTests: TestCase {
    
    // MARK: - Tests -
    
    func testAnimate() {
        ViewAnimatorHelper.animate(views: [UIView()], type: .from)
        ViewAnimatorHelper.animate(views: [UIView()], type: .rotate)
        ViewAnimatorHelper.animate(views: [UIView()], type: .zoom)
    }
    
    func testAnimateFailure() {
        ViewAnimatorHelper.animate(views: nil)
    }
}
