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

class MovieShowsView: UIViewController {
    // MARK: - Outlets -
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - View Model -
    
    var viewModel: MovieShowsViewModel?
    
    // MARK: - Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewModel()
    }
    
    // MARK: - Setup -
    
    private func setupAppearance() {
        collectionView.keyboardDismissMode = .onDrag
    }

    private func setupViewModel() {
        viewModel?.delegate = self
        viewModel?.loadData()
    }
}

extension MovieShowsView: ViewModelDelegate {
    func reloadData() {
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func showAlert(message: String?) {
        alertController?.show(message: message)
    }
}

extension MovieShowsView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(MovieShowViewCell.self, for: indexPath)
        cell.viewModel = viewModel?.movieShowCellViewModel(at: indexPath)
        cell.setupView(at: indexPath, withLayout: collectionView.collectionViewLayout as? CollectionViewSlantedLayout)
        return cell
    }
}

extension MovieShowsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
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

extension MovieShowsView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
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
