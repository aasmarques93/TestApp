//
//  ExploreCellTests.swift
//  TestAppTests
//
//  Created by Arthur Augusto Sousa Marques on 8/1/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import XCTest

@testable import TestApp

class ExploreCellTests: TestCase {
    // MARK: - Properties -
    
    private var genre: Genre!
    private var viewModel: ExploreCellViewModel!
    private var exploreViewCell: ExploreViewCell!
    private var imageView: UIImageView!
    
    // MARK: - Setup -
    
    override func setUp() {
        super.setUp()
        genre = Genre(object: ["name": "Action"])
        viewModel = ExploreCellViewModel(object: genre)
        exploreViewCell = ExploreViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        imageView = UIImageView(frame: exploreViewCell.frame)
        imageView.image = #imageLiteral(resourceName: "logo")
        exploreViewCell.imageView = imageView
        exploreViewCell.labelTitle = UILabel()
    }
    
    override func tearDown() {
        super.tearDown()
        genre = nil
        viewModel = nil
        exploreViewCell = nil
    }
    
    // MARK: - Tests -
    
    func testSetupView() {
        exploreViewCell?.setupView()
        XCTAssertNotNil(exploreViewCell)
    }
    
    func testLoadData() {
        viewModel.loadData()
        XCTAssertNotNil(viewModel.image.value)
        XCTAssertNotNil(viewModel.title.value)
    }
}
