//
//  MovieShowsViewModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/9/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation

class MovieShowsViewModel: ViewModel, LoadingProtocol {
    // MARK: - Properties -
    
    var loading: Loading = Loading()
    
    // MARK: Delegate
    weak var delegate: ViewModelDelegate?
    
    // MARK: Service Model
    private let serviceModel = MovieShowsServiceModel()
    
    // MARK: Objects
    private var arrayMovieShows = [MovieShow]()
    private var currentPage: Int = 1
    var numberOfItems: Int { return arrayMovieShows.count }
    var isResultEmpty: Bool { return numberOfItems == 0 }
    
    // MARK: Variables
    private var isMoviesTab: Bool
    private var isDataLoading = false
    
    private var selectedTab: MovieShowTab
    
    // MARK: - Life cycle -
    
    init(selectedTab: MovieShowTab, isMoviesTab: Bool) {
        self.selectedTab = selectedTab
        self.isMoviesTab = isMoviesTab
    }
    
    // MARK: - Service Requests -
    
    func loadData() {
        isDataLoading = true
        
        let parameters: [String: Any] = [
            "page": currentPage,
            "language": Locale.preferredLanguages.first ?? ""
        ]
        
        loading.start()
        serviceModel.getMovieShows(requestUrl: selectedTab.requestUrl, urlParameters: parameters) { [weak self] (object) in
            self?.loading.stop()
            
            do {
                try self?.throwError(with: object)
            } catch {
                self?.delegate?.showAlert?(message: error.localizedDescription)
                return
            }
            
            if let results = object.results {
                self?.arrayMovieShows.append(contentsOf: results)
                self?.currentPage += 1
            }
            self?.reloadData()
        }
    }
    
    // MARK: - View Model methods -
    
    func reloadData() {
        delegate?.reloadData?()
        isDataLoading = false
    }
    
    func loadDataPaginationIfNeeded(at indexPath: IndexPath) {
        guard indexPath.row == arrayMovieShows.count-2 && !isDataLoading else {
            return
        }
        loadData()
    }
    
    // MARK: - View Model instantiation -
    
    func movieShowCellViewModel(at indexPath: IndexPath) -> MovieShowCellViewModel? {
        guard indexPath.row < arrayMovieShows.count else {
            return nil
        }
        return MovieShowCellViewModel(object: arrayMovieShows[indexPath.row])
    }
    
    func movieShowDetailViewModel(at indexPath: IndexPath) -> MovieShowDetailViewModel? {
        guard indexPath.row < arrayMovieShows.count else {
            return nil
        }
        return MovieShowDetailViewModel(object: arrayMovieShows[indexPath.row], isMoviesTab: isMoviesTab)
    }
}
