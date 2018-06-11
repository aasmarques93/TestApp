//
//  MovieShowXIBView.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/9/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

class MovieShowXibView: XibView {
    // MARK: - Outlets -
    @IBOutlet weak var imageViewMovie: UIImageView!
    
    // MARK: - Life cycle -
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor(colorStyle: .primary)
        imageViewMovie.backgroundColor = backgroundColor
    }
}
