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
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var labelTitle: UILabel!
    @IBOutlet var labelAverage: UILabel!
    
    // MARK: - Properties -
    
    var viewModel: MovieShowCellViewModel?

    // MARK: - Setup -
    
    func setupView(at indexPath: IndexPath, withLayout layout: CollectionViewSlantedLayout?) {
        viewModel?.loadData()
        setupBidings()
        setupAppearance(withLayout: layout)
        setupContent()
    }
    
    private func setupBidings() {
        viewModel?.title.bind(to: labelTitle.reactive.text)
        viewModel?.average.bind(to: labelAverage.reactive.text)
    }
    
    private func setupAppearance(withLayout layout: CollectionViewSlantedLayout?) {
        guard let layout = layout else {
            return
        }
        contentView.transform = CGAffineTransform(rotationAngle: layout.slantingAngle)
    }
    
    private func setupContent() {
        imageView.sd_setImage(with: viewModel?.imagePathUrl, placeholderImage: UIImage())
        ViewAnimatorHelper.animate(views: [labelTitle, labelAverage], direction: .top)
    }
    
    // MARK: - Parallax Effect Methods -
    
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
    
    // MARK: - Life cycle -
    
    deinit {
        imageView = nil
        labelTitle = nil
        labelAverage = nil
    }
}
