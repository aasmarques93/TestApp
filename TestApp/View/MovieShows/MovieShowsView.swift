//
//  MovieShowsView.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/9/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit
import CollectionViewSlantedLayout

private let offsetSpeed: CGFloat = 150
private let cellHeight: CGFloat = 275

class MovieShowsView: UICollectionViewController {
    // MARK: - View Model -
    
    var viewModel: MovieShowsViewModel?
    
    // MARK: - Life cycle -
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewModel()
    }
    
    // MARK: - Setup -
    
    private func setupViewModel() {
        viewModel?.delegate = self
        viewModel?.loadData()
    }
}

extension MovieShowsView: ViewModelDelegate {
    func reloadData() {
        collectionView?.reloadData()
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func showAlert(message: String?) {
        alertController?.show(message: message)
    }
}

// MARK: - UICollectionViewDataSource -

extension MovieShowsView {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(MovieShowViewCell.self, for: indexPath)
        cell.viewModel = viewModel?.movieShowCellViewModel(at: indexPath)
        cell.setupView(at: indexPath, withLayout: collectionView.collectionViewLayout as? CollectionViewSlantedLayout)
        return cell
    }
}

// MARK: - UICollectionViewDelegate -

extension MovieShowsView {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = instantiate(viewController: MovieShowDetailView.self, from: .movieShowDetail)
        viewController.viewModel = viewModel?.movieShowDetailViewModel(at: indexPath)
        navigationController?.pushViewController(viewController, animated: true)
    }

    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel?.loadDataPaginationIfNeeded(at: indexPath)
    }
}

extension MovieShowsView: CollectionViewDelegateSlantedLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: CollectionViewSlantedLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
}

// MARK: - UIScrollViewDelegate -

extension MovieShowsView {
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = collectionView, let visibleCells = collectionView.visibleCells as? [MovieShowViewCell] else {
            return
        }
        visibleCells.forEach { (parallaxCell) in
            let yOffset = ((collectionView.contentOffset.y - parallaxCell.frame.origin.y) / parallaxCell.imageHeight) * offsetSpeed
            let xOffset = ((collectionView.contentOffset.x - parallaxCell.frame.origin.x) / parallaxCell.imageWidth) * offsetSpeed
            parallaxCell.offset(CGPoint(x: xOffset, y: yOffset))
        }
    }
}
