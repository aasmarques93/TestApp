//
//  ExploreView.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/13/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

private let margin: CGFloat = 2
private let numberOfColumns: CGFloat = 2

class ExploreView: UICollectionViewController {
    
    // MARK: - Properties -
    
    let viewModel = ExploreViewModel()
    
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
        ViewAnimatorHelper.animate(views: collectionView?.visibleCells(in: 0))
    }
    
    // MARK: - Setup -
    
    private func setupAppearance() {
        title = Titles.explore.localized
        collectionView?.collectionViewLayout = collectionViewFlowLayout
    }
}

// MARK: - UICollectionViewDataSource -

extension ExploreView {
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

// MARK: - UICollectionViewDelegate -

extension ExploreView {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = instantiate(viewController: MovieShowsView.self, from: .movieShows)
        viewController.viewModel = viewModel.movieShowsViewModel(at: indexPath)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ExploreView: ViewModelDelegate {
    func reloadData() {
        collectionView?.reloadData()
    }
}
