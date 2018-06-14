//
//  ExploreViewCell.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/13/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

class ExploreViewCell: UICollectionViewCell {
    
    // MARK: - Outlets -
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    
    // MARK: - Properties -
    
    var viewModel: ExploreCellViewModel?
    
    // MARK: - Setup -
    
    func setupView() {
        viewModel?.image.bind(to: imageView.reactive.image)
        viewModel?.title.bind(to: labelTitle.reactive.text)
        viewModel?.loadData()
    }
    
    // MARK: - Life cycle -
    
    deinit {
        imageView = nil
        labelTitle = nil
    }
}
