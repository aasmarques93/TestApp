//
//  MovieShowViewCellTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 8/1/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp
@testable import NVActivityIndicatorView

class MovieShowViewCellTests: TestCase {
    // MARK: - Properties -
    
    private var movieShow: MovieShow!
    private var viewModel: MovieShowCellViewModel!
    private var movieShowViewCell: MovieShowViewCell!
    private var imageView: UIImageView!
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        movieShow = MovieShow(object: ["title": "Test"])
        viewModel = MovieShowCellViewModel(object: movieShow)
        movieShowViewCell = MovieShowViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView = UIImageView(frame: movieShowViewCell.frame)
        imageView.image = #imageLiteral(resourceName: "logo")
        movieShowViewCell.imageView = imageView
        movieShowViewCell.activityIndicator = NVActivityIndicatorView(frame: .zero)
        movieShowViewCell.labelTitle = UILabel()
        movieShowViewCell.labelAverage = UILabel()
        movieShowViewCell.viewModel = viewModel
    }
    
    override func tearDown() {
        super.tearDown()
        movieShow = nil
        viewModel = nil
        movieShowViewCell = nil
    }
    
    // MARK: - Tests -
    
    func testSetupView() {
        movieShowViewCell?.setupView(at: IndexPath(item: 0, section: 0), withLayout: nil)
        XCTAssertNotNil(movieShowViewCell)
    }
    
    func testImageWidth() {
        XCTAssertFalse(movieShowViewCell.imageWidth == 0)
    }
    
    func testImageWidthFailure() {
        movieShowViewCell.imageView = nil
        XCTAssertTrue(movieShowViewCell.imageWidth == 0)
    }
    
    func testImageHeight() {
        XCTAssertFalse(movieShowViewCell.imageHeight == 0)
    }
    
    func testImageHeightFailure() {
        movieShowViewCell.imageView = nil
        XCTAssertTrue(movieShowViewCell.imageHeight == 0)
    }
    
    func testOffset() {
        movieShowViewCell.offset(CGPoint(x: 0, y: 0))
        XCTAssertTrue(movieShowViewCell.imageView.frame.minX == 0)
    }
    
    func testOffsetFailure() {
        movieShowViewCell.offset(CGPoint(x: CGFloat.nan, y: CGFloat.nan))
        XCTAssertTrue(movieShowViewCell.imageView.frame.minX == 0)
    }
}
