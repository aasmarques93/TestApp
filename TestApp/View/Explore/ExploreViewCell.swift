//
//  ExploreViewCell.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/13/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

class ExploreViewCell: UICollectionViewCell {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    
    var viewModel: ExploreCellViewModel?
    
    func setupView() {
        viewModel?.image.bind(to: imageView.reactive.image)
        viewModel?.title.bind(to: labelTitle.reactive.text)
        viewModel?.loadData()
    }
    
    deinit {
        imageView = nil
        labelTitle = nil
    }
}
