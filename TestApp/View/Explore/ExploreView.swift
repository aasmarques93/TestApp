//
//  ExploreView.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 8/1/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

private let margin: CGFloat = 2
private let numberOfColumns: CGFloat = 2

class ExploreView: UICollectionViewController {
    
    // MARK: - Properties -
    
    lazy var searchBar = UISearchBar(frame: .zero)
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
        ViewAnimatorHelper.animate(views: collectionView?.visibleCells(in: 0), direction: .bottom)
    }
    
    // MARK: - Setup -
    
    private func setupAppearance() {
        searchBar.placeholder = Titles.explore.localized
        searchBar.delegate = self
        
        let textField = searchBar.value(forKey: "_searchField") as? UITextField
        textField?.backgroundColor = ColorStyle.primary.color
        textField?.textColor = ColorStyle.text.color
        
        navigationItem.titleView = searchBar
        collectionView?.collectionViewLayout = collectionViewFlowLayout
        collectionView?.keyboardDismissMode = .onDrag
    }
    
    private func pushMovieShowsView(viewModel: MovieShowsViewModel) {
        let viewController = instantiate(viewController: MovieShowsView.self, from: .movieShows)
        viewController.viewModel = viewModel
        navigationController?.pushViewController(viewController, animated: true)
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
        pushMovieShowsView(viewModel: viewModel.movieShowsViewModel(at: indexPath))
    }
}

extension ExploreView: ExploreViewModelDelegate {
    func reloadData() {
        collectionView?.reloadData()
    }
    
    func didFinishSearch(_ movieShowsViewModel: MovieShowsViewModel) {
        pushMovieShowsView(viewModel: movieShowsViewModel)
    }
}

// MARK: - UISearchBarDelegate -

extension ExploreView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchMovieShow(text: searchBar.text)
    }
}
