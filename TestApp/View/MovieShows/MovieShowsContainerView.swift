//
//  MovieShowContainerView.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/10/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

class MovieShowsContainerView: UIViewController {
    
    // MARK: - Properties -
    
    var pagerView: PagerView?
    var pageViewController: PageViewController?
    
    var viewModel: MovieShowsContainerViewModel?
    
    // MARK: Variables
    var isMoviesTab: Bool {
        return navigationController?.tabIndex == 0
    }
    
    // MARK: - Life cycle -
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupAppearance()
        setupContent()
    }
    
    // MARK: - Setup -
    
    func setupAppearance() {
        setTitleView(text: isMoviesTab ? Titles.movies.localized : Titles.tvShows.localized)
    }
    
    func setupContent() {
        guard viewModel == nil else {
            return
        }
        setupViewModel()
        setupPagerView()
        setupPageViewController()
    }
    
    private func setupViewModel() {
        viewModel = MovieShowsContainerViewModel(isMoviesTab: isMoviesTab)
    }
    
    func setupPagerView() {
        pagerView?.delegate = self
        pagerView?.viewModel = viewModel?.pagerViewModel()
    }
    
    func setupPageViewController() {
        pageViewController?.pageViewControllerDelegate = self
        pageViewController?.viewModel = viewModel
        pageViewController?.setupStartViewController()
    }
    
    // MARK: - Segues -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? PagerView {
            pagerView = viewController
        }
        if let viewController = segue.destination as? PageViewController {
            pageViewController = viewController
        }
    }
}

extension MovieShowsContainerView: PagerViewDelegate {
    func didSelect(at indexPath: IndexPath) {
        pageViewController?.setupStartViewController(index: indexPath.item)
    }
}

extension MovieShowsContainerView: PageViewControllerDelegate {
    func didFinishAnimating(at indexPath: IndexPath) {
        pagerView?.selectItem(at: indexPath)
    }
}
