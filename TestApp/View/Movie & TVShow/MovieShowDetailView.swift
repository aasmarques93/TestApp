//
//  MovieShowDetailView.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/9/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit
import Bond

class MovieShowDetailView: UITableViewController {
    // MARK: - Outlets -
    
    @IBOutlet weak var labelAverage: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelRuntime: UILabel!
    
    @IBOutlet weak var textViewGenres: UITextView!
    @IBOutlet weak var textViewOverview: UITextView!
    
    @IBOutlet weak var carouselRecommendedMovies: iCarousel!
    @IBOutlet weak var carouselSimilarMovies: iCarousel!
    
    @IBOutlet var stretchHeaderView: StretchHeaderView!
    
    // MARK: - Properties -
    
    private enum DetailRow: Int {
        case general = 1
        case genres = 2
        case overview = 3
        case recommended = 4
        case similiarMovies = 5
    }
    
    // MARK: - View Model -
    
    var viewModel: MovieShowDetailViewModel?
        
    // MARK: - Life cycle -
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.delegate = self
        viewModel?.loadData()
        setupBindings()
        setupAppearance()
    }
    
    // MARK: - View model bindings -
    
    private func setupBindings() {
        viewModel?.average.bind(to: labelAverage.reactive.text)
        viewModel?.date.bind(to: labelDate.reactive.text)
        viewModel?.runtime.bind(to: labelRuntime.reactive.text)
        viewModel?.genres.bind(to: textViewGenres.reactive.text)
        viewModel?.overview.bind(to: textViewOverview.reactive.text)
    }
    
    // MARK: - Appearance -
    
    private func setupAppearance() {
        title = viewModel?.movieName
        
        carouselRecommendedMovies.type = .rotary
        carouselSimilarMovies.type = .rotary
        
        stretchHeaderView.setupHeaderView(tableView: tableView)
    }
    
    // MARK: - Table view data source -
    
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
                if viewModel?.numberOfRecommendedMovies == 0 { height = 0 }
            case .similiarMovies:
                if viewModel?.numberOfSimilarMovies == 0 { height = 0 }
            }
        }
        return height
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == tableView {
            stretchHeaderView.scrollViewDidScroll(scrollView)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        stretchHeaderView.deviceOrientationDidRotate(to: size)
    }
}

extension MovieShowDetailView: MovieShowDetailViewModelDelegate {
    
    // MARK: - Movie detail view model delegate -
    
    func showAlert(message: String?) {
        alertController?.show(message: message)
    }
    
    func reloadData() {
        tableView.reloadData()
        stretchHeaderView.setupHeaderView(tableView: tableView, imageUrl: viewModel?.imageUrl)
    }
    
    func reloadRecommendedMovies() {
        carouselRecommendedMovies.reloadData()
    }
    
    func reloadSimilarMovies() {
        carouselSimilarMovies.reloadData()
    }
}

extension MovieShowDetailView: iCarouselDelegate, iCarouselDataSource {
    
    // MARK: - iCarousel delegate and data source -
    
    func numberOfItems(in carousel: iCarousel) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        if carousel == carouselRecommendedMovies { return viewModel.numberOfRecommendedMovies }
        return viewModel.numberOfSimilarMovies
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        if carousel == carouselRecommendedMovies { return carouselRecommendationView(at: index) }
        return carouselSimilarMovieView(at: index)
    }
    
    func carouselRecommendationView(at index: Int) -> UIView {
        let view = XibView.instanceFromNib(MovieShowXibView.self)
        view.imageViewMovie.sd_setImage(with: viewModel?.movieRecommendationImageUrl(at: index), placeholderImage: #imageLiteral(resourceName: "logo"))
        return view
    }
    
    func carouselSimilarMovieView(at index: Int) -> UIView {
        let view = XibView.instanceFromNib(MovieShowXibView.self)
        view.imageViewMovie.sd_setImage(with: viewModel?.similarMovieImageUrl(at: index), placeholderImage: #imageLiteral(resourceName: "logo"))
        return view
    }
    
    func carousel(_ carousel: iCarousel, didSelectItemAt index: Int) {
        if carousel == carouselRecommendedMovies {
            let viewController = instantiate(viewController: MovieShowDetailView.self, from: .movieShow)
            viewController.viewModel = viewModel?.recommendedMovieShowDetailViewModel(at: index)
            navigationController?.pushViewController(viewController, animated: true)
            return
        }
        if carousel == carouselSimilarMovies {
            let viewController = instantiate(viewController: MovieShowDetailView.self, from: .movieShow)
            viewController.viewModel = viewModel?.similarMovieShowDetailViewModel(at: index)
            navigationController?.pushViewController(viewController, animated: true)
            return
        }
    }
}
