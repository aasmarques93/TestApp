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
    
    internal var loading: Loading = Loading()
    
    // MARK: Delegate
    weak var delegate: ViewModelDelegate?
    
    // MARK: Service Model
    private let serviceModel = MovieShowsServiceModel()
    
    // MARK: Objects
    private var arrayMovieShows = [MovieShow]()
    private var currentPage: Int = 1
    var numberOfItems: Int { return arrayMovieShows.count }
    
    private var arrayCache: [MovieShow] {
        guard let array = LocalStorageHelper.fetch(requestUrl: selectedTab.requestUrl) as? [[String: Any]] else {
            return []
        }
        return array.map { MovieShow(object: $0) }
    }
    
    // MARK: Variables
    private var isMoviesTab: Bool
    private var isDataLoading = false
    
    private var selectedTab: MovieShowTab
    
    private var parameters: [String: Any] {
        return [
            "page": currentPage,
            "language": Locale.preferredLanguages.first ?? ""
        ]
    }
    
    // MARK: - Life cycle -
    
    init(selectedTab: MovieShowTab, isMoviesTab: Bool) {
        self.selectedTab = selectedTab
        self.isMoviesTab = isMoviesTab
    }
    
    // MARK: - Service Requests -
    
    func loadData(forceRefresh: Bool = false) {
        guard forceRefresh || arrayCache.isEmpty else {
            arrayMovieShows = arrayCache
            reloadData()
            return
        }
        
        isDataLoading = true
        loading.start()
        serviceModel.getMovieShows(requestUrl: selectedTab.requestUrl, urlParameters: parameters) { [weak self] (object) in
            self?.loading.stop()
            
            do {
                try self?.throwError(with: object)
            } catch {
                self?.delegate?.showAlert?(message: error.localizedDescription)
                return
            }
            
            self?.arrayMovieShows.append(contentsOf: object.results ?? [])
            self?.currentPage += 1
            self?.reloadData()
            
            LocalStorageHelper.save(object: self?.arrayMovieShows.map { $0.dictionaryRepresentation() },
                                    requestUrl: self?.selectedTab.requestUrl)
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
        loadData(forceRefresh: true)
    }
    
    // MARK: - View Model instantiation -
    
    func movieShowCellViewModel(at indexPath: IndexPath) -> MovieShowCellViewModel? {
        guard indexPath.row < arrayMovieShows.count else {
            return nil
        }
        return MovieShowCellViewModel(object: arrayMovieShows[indexPath.row])
    }
    
    func movieShowDetailViewModel(at indexPath: IndexPath?) -> MovieShowDetailViewModel? {
        guard let indexPath = indexPath, indexPath.row < arrayMovieShows.count else {
            return nil
        }
        return MovieShowDetailViewModel(object: arrayMovieShows[indexPath.row], isMoviesTab: isMoviesTab)
    }
}
