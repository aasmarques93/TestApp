//
//  MovieShowViewCell.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/9/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit
import SDWebImage
import CollectionViewSlantedLayout

class MovieShowViewCell: CollectionViewSlantedCell {
    // MARK: - Outlets -
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var viewTitle: UIView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelAverage: UILabel!
    
    // MARK: - Properties -
    
    var viewModel: MovieShowCellViewModel?

    // MARK: - Setup -
    
    func setupView(at indexPath: IndexPath, withLayout layout: CollectionViewSlantedLayout?) {
        setupBidings()
        setupAppearance(at: indexPath, withLayout: layout)
        imageView.sd_setImage(with: viewModel?.imagePathUrl, placeholderImage: UIImage())
        viewModel?.loadData()
    }
    
    private func setupBidings() {
        viewModel?.title.bind(to: labelTitle.reactive.text)
        viewModel?.average.bind(to: labelAverage.reactive.text)
    }
    
    private func setupAppearance(at indexPath: IndexPath, withLayout layout: CollectionViewSlantedLayout?) {
        guard let layout = layout else {
            return
        }
        contentView.transform = CGAffineTransform(rotationAngle: layout.slantingAngle)
        viewTitle.transform = CGAffineTransform(rotationAngle: indexPath.row > 0 ? layout.slantingAngle : 0)
    }
    
    var imageHeight: CGFloat {
        return imageView?.image?.size.height ?? 0
    }
    
    var imageWidth: CGFloat {
        return imageView?.image?.size.width ?? 0
    }
    
    func offset(_ offset: CGPoint) {
        if offset.x.isNaN || offset.y.isNaN { return }
        imageView.frame = imageView.bounds.offsetBy(dx: offset.x, dy: offset.y)
    }
}
