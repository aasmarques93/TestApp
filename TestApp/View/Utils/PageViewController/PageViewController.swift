//
//  PageViewController.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/10/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

protocol PageViewControllerDelegate: class {
    func didFinishAnimating(at indexPath: IndexPath)
}

class PageViewController: UIPageViewController {
    
    // MARK: - Protocols -
    
    weak var pageViewControllerDelegate: PageViewControllerDelegate?
    
    // MARK: - View Model -
    
    var viewModel: MovieShowsContainerViewModel?
    
    // MARK: - Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
    }

    // MARK: - Setup -
    
    func setupStartViewController(index: Int = 0) {
        let viewController = createViewController(index: index)
        self.setViewControllers([viewController],
                                direction: index > getCurrentPageIndex() ? .forward : .reverse,
                                animated: true,
                                completion: nil)
    }
    
    func createViewController(index: Int) -> UIViewController {
        let viewController = instantiate(viewController: MovieShowsView.self, from: .movieShows)
        viewController.pageIndex = index
        viewController.viewModel = viewModel?.movieShowsViewModel(at: index)
        return viewController
    }
}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard var index = viewController.pageIndex, index > 0 && index != NSNotFound else {
            return nil
        }
        
        index -= 1
        return createViewController(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard var index = viewController.pageIndex, index != NSNotFound else {
            return nil
        }
        
        index += 1
        guard let count = viewModel?.titles.count, index < count else {
            return nil
        }
        return createViewController(index: index)
    }
}

extension PageViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController,
                            didFinishAnimating finished: Bool,
                            previousViewControllers: [UIViewController],
                            transitionCompleted completed: Bool) {
        
        pageViewControllerDelegate?.didFinishAnimating(at: IndexPath(item: getCurrentPageIndex(), section: 0))
    }
}
