//
//  MovieShowDetailView.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/9/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit
import Bond
import iCarousel

class MovieShowDetailView: UITableViewController {
    
    // MARK: - Outlets -
    
    @IBOutlet var stretchHeaderView: StretchHeaderView!
    
    @IBOutlet weak var circularProgressView: CircularProgressView!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelRuntime: UILabel!
    
    @IBOutlet weak var textViewGenres: UITextView!
    @IBOutlet weak var textViewOverview: UITextView!
    
    @IBOutlet weak var carouselRecommendedMovieShows: iCarousel!
    
    // MARK: - Properties -
    
    private enum DetailRow: Int {
        case general = 0
        case genres = 1
        case overview = 2
        case recommended = 3
    }
    
    // MARK: - View Model -
    
    var viewModel: MovieShowDetailViewModel?
        
    // MARK: - Life cycle -
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewModel()
        setupBindings()
        setupAppearance()
        setupAnimations()
    }
    
    // MARK: - Setup -
    
    private func setupViewModel() {
        viewModel?.delegate = self
        viewModel?.loadData()
    }
    
    private func setupBindings() {
        viewModel?.date.bind(to: labelDate.reactive.text)
        viewModel?.runtime.bind(to: labelRuntime.reactive.text)
        viewModel?.genres.bind(to: textViewGenres.reactive.text)
        viewModel?.overview.bind(to: textViewOverview.reactive.text)
    }
    
    private func setupAppearance() {
        title = viewModel?.movieShowTitle
        carouselRecommendedMovieShows.type = .rotary
        stretchHeaderView.setupHeaderView(tableView: tableView)
    }
    
    private func setupAnimations() {
        ViewAnimatorHelper.animate(views: [labelDate, labelRuntime])
    }
    
    // MARK: - UITableViewDataSource -
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = super.tableView(tableView, heightForRowAt: indexPath)
        if let row = DetailRow(rawValue: indexPath.row) {
            switch row {
            case .general:
                break
            case .genres:
                height += textViewGenres.contentSize.height
            case .overview:
                height += textViewOverview.contentSize.height
            case .recommended:
                if viewModel?.numberOfRecommendedMovieShows == 0 { height = 0 }
            }
        }
        return height
    }
    
    // MARK: - UIScrollViewDelegate -
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView == tableView else {
            return
        }
        stretchHeaderView.scrollViewDidScroll(scrollView)
    }
}

extension MovieShowDetailView: MovieShowDetailViewModelDelegate {
    func showAlert(message: String?) {
        alertController?.show(message: message)
    }
    
    func reloadData() {
        tableView.reloadData()
        stretchHeaderView.setupHeaderView(tableView: tableView, imageUrl: viewModel?.imageUrl)
        circularProgressView.progress = viewModel?.average ?? 0
        
        ViewAnimatorHelper.animate(views: [circularProgressView], type: .rotate)
        ViewAnimatorHelper.animate(views: tableView.visibleCells(in: 0))
    }
    
    func reloadRecommendedMovieShows() {
        carouselRecommendedMovieShows.reloadData()
    }
}

extension MovieShowDetailView: iCarouselDelegate, iCarouselDataSource {    
    func numberOfItems(in carousel: iCarousel) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.numberOfRecommendedMovieShows
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        let view = XibView.instanceFromNib(MovieShowXibView.self)
        view.imageViewMovie.sd_setImage(with: viewModel?.movieShowRecommendedImageUrl(at: index), placeholderImage: #imageLiteral(resourceName: "logo"))
        return view
    }

    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        let viewController = instantiate(viewController: MovieShowDetailView.self, from: .movieShowDetail)
        viewController.viewModel = viewModel?.recommendedMovieShowDetailViewModel(at: index)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
