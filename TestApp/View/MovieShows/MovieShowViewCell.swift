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
import NVActivityIndicatorView

class MovieShowViewCell: CollectionViewSlantedCell {
    
    // MARK: - Outlets -
    
    @IBOutlet var activityIndicator: NVActivityIndicatorView!
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
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        imageView.sd_setImage(with: viewModel?.imagePathUrl,
                              placeholderImage: UIImage(),
                              options: []) { [weak self] (image, error, type, url) in
                                
                                self?.activityIndicator.isHidden = true
        }
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
        activityIndicator = nil
        imageView = nil
        labelTitle = nil
        labelAverage = nil
    }
}
