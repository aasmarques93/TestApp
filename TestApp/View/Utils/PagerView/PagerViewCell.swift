//
//  PagerViewCell.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/10/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

class PagerViewCell: UICollectionViewCell {
    // MARK: Outlets
    @IBOutlet weak var labelTitle: UILabel!
    
    // MARK: View Model
    var viewModel: PagerViewModel?
    
    // MARK: Setup
    func setupView(at indexPath: IndexPath) {
        labelTitle.text = viewModel?.title(at: indexPath)
        labelTitle.adjustsFontSizeToFitWidth = true
    }
}
