//
//  ExploreViewModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 8/1/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation

protocol ExploreViewModelDelegate: ViewModelDelegate {
    func didFinishSearch(_ movieShowsViewModel: MovieShowsViewModel)
}

class ExploreViewModel: ViewModel, LoadingProtocol {
    // MARK: - Properties -
    
    internal var loading: Loading = Loading()
    
    // MARK: Delegate
    weak var delegate: ExploreViewModelDelegate?
    
    // MARK: Service Model
    private let serviceModel = ExploreServiceModel()
    
    // MARK: Objects
    private var arrayGenres = [Genre]() { didSet { delegate?.reloadData?() } }
    var numberOfItems: Int { return arrayGenres.count }
    
    // MARK: - Service Requests -
    
    func loadData() {
        loading.start()
        serviceModel.getGenres { [weak self] (object) in
            self?.loading.stop()
            self?.arrayGenres = object.genres ?? []
        }
    }
    
    func searchMovieShow(text: String?) {
        loading.start()
        serviceModel.searchMovieShow(query: text) { [weak self] (object) in
            self?.loading.stop()
            
            var results = object.results ?? []
            results = results.filter { $0.mediaType == "movie" }
            self?.delegate?.didFinishSearch(MovieShowsViewModel(selectedTab: .searchByText,
                                                                isMoviesTab: true,
                                                                query: text,
                                                                arrayMovieShows: results))
        }
    }
    
    // MARK: - View Model -
    
    func exploreCellViewModel(at indexPath: IndexPath) -> ExploreCellViewModel {
        return ExploreCellViewModel(object: arrayGenres[indexPath.item])
    }
    
    func movieShowsViewModel(at indexPath: IndexPath) -> MovieShowsViewModel {
        return MovieShowsViewModel(selectedTab: .searchByGenre, isMoviesTab: true, genre: arrayGenres[indexPath.item])
    }
}
