//
//  ExploreView.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/13/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit
import ViewAnimator

private let animations = [AnimationType.from(direction: .right, offset: 30.0)]
private let margin: CGFloat = 2
private let numberOfColumns: CGFloat = 2

class ExploreView: UICollectionViewController {
    // MARK: - Properties -
    
    private let viewModel = ExploreViewModel()
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        
        var itemWidth = (SCREEN_WIDTH - (margin * (numberOfColumns + 1))) / numberOfColumns
        itemWidth -= margin * 2
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        return layout
    }
    
    // MARK: - Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        viewModel.loadData()
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(views: collectionView?.visibleCells(in: 0) ?? [], animations: animations)
    }
    
    // MARK: - Setup Appearance -
    
    private func setupAppearance() {
        title = Titles.explore.localized
        collectionView?.collectionViewLayout = collectionViewFlowLayout
    }
    
    // MARK: - UICollectionViewDataSource -
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ExploreViewCell.self, for: indexPath)
        cell.viewModel = viewModel.exploreCellViewModel(at: indexPath)
        cell.setupView()
        return cell
    }
}

extension ExploreView: ViewModelDelegate {
    func reloadData() {
        collectionView?.reloadData()
    }
    
    func showAlert(message: String?) {
        alertController?.show(message: message)
    }
}
