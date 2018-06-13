//
//  StretchHeaderView.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/9/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

class StretchHeaderView: UIView {
    private var imageViewHeader = UIImageView()
    private var activityIndicator = UIActivityIndicatorView()
    
    private var minHeightPercentual: CGFloat = 0, maxHeightPercentual: CGFloat = 1.0
    
    func setupHeaderView(tableView: UITableView,
                         imageUrl: URL? = nil,
                         minHeightPercentual: CGFloat = 0,
                         maxHeightPercentual: CGFloat = 0.5) {
        
        self.minHeightPercentual = minHeightPercentual
        self.maxHeightPercentual = maxHeightPercentual
        
        frame = CGRect(x: frame.minX, y: frame.height * -1, width: tableView.frame.width, height: frame.height)
        
        imageViewHeader.frame = frame
        imageViewHeader.contentMode = .scaleAspectFill
        imageViewHeader.clipsToBounds = true
        imageViewHeader.sd_setImage(with: imageUrl, completed: nil)
        imageViewHeader.removeFromSuperview()
        tableView.addSubview(imageViewHeader)
        
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.center = CGPoint(x: imageViewHeader.center.x, y: imageViewHeader.center.y)
        activityIndicator.startAnimating()
        activityIndicator.removeFromSuperview()
        if imageUrl == nil { tableView.addSubview(activityIndicator) }
        
        tableView.contentInset = UIEdgeInsetsMake(frame.height, 0, 0, 0)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y = frame.height - (scrollView.contentOffset.y + frame.height)
        let newHeight = min(max(y, minHeightPercentual), frame.height * (maxHeightPercentual + 1))
        imageViewHeader.frame = CGRect(x: 0, y: scrollView.contentOffset.y, width: imageViewHeader.frame.width, height: newHeight)
    }
}
