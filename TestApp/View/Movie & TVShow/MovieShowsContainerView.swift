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
    
    // MARK: - Life cycle -
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewModel()
        setupPagerView()
        setupPageViewController()
    }
    
    // MARK: - Setup -
    
    private func setupViewModel() {
        let isMoviesTab = navigationController?.tab == 0
        viewModel = MovieShowsContainerViewModel(isMoviesTab: isMoviesTab)
    }
    
    private func setupPagerView() {
        pagerView?.delegate = self
        pagerView?.viewModel = viewModel?.pagerViewModel()
    }
    
    private func setupPageViewController() {
        pageViewController?.pageViewControllerDelegate = self
        pageViewController?.viewModel = viewModel
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
        pageViewController?.setupStartViewController(index: indexPath.row)
    }
}

extension MovieShowsContainerView: PageViewControllerDelegate {
    func didFinishAnimating(at indexPath: IndexPath) {
        pagerView?.selectItem(at: indexPath)
    }
}
