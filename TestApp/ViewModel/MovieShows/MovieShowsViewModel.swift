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
    private var selectedTab: MovieShowTab
    private var genre: Genre?
    var genreTitle: String? { return genre?.name }
    
    private var parameters: [String: Any] {
        return [
            "page": currentPage,
            "language": Locale.preferredLanguages.first ?? "",
            "id": genre?.id ?? 0
        ]
    }
    private var isDataLoading = false
    
    // MARK: - Life cycle -
    
    init(selectedTab: MovieShowTab, isMoviesTab: Bool, genre: Genre? = nil) {
        self.selectedTab = selectedTab
        self.isMoviesTab = isMoviesTab
        self.genre = genre
    }
    
    // MARK: - Service Requests -
    
    func loadData(forceRefresh: Bool = false, isPagination: Bool = false) {
        guard forceRefresh || arrayCache.isEmpty || selectedTab.requestUrl == .searchByGenre else {
            arrayMovieShows = arrayCache
            delegate?.reloadData?()
            return
        }

        if forceRefresh && !isPagination {
            arrayMovieShows = []
            currentPage = 1
        } else if arrayMovieShows.isEmpty {
            loading.start()
        }
        
        isDataLoading = true
        serviceModel.getMovieShows(requestUrl: selectedTab.requestUrl, urlParameters: parameters) { [weak self] (object) in
            self?.loading.stop()
            self?.handleResponse(object)
        }
    }
    
    private func handleResponse(_ object: MovieShowsList) {
        do {
            try throwError(with: object)
        } catch {
            delegate?.showAlert?(message: error.localizedDescription)
            return
        }
        
        arrayMovieShows.append(contentsOf: object.results ?? [])
        saveMovieShows()
        currentPage += 1
        isDataLoading = false
        delegate?.reloadData?()
    }
    
    func loadDataPaginationIfNeeded(at indexPath: IndexPath) {
        guard indexPath.item == arrayMovieShows.count-2 && !isDataLoading else {
            return
        }
        loadData(forceRefresh: true, isPagination: true)
    }
    
    private func saveMovieShows() {
        guard currentPage == 1 else {
            return
        }
        _ = LocalStorageHelper.save(object: arrayMovieShows.map { $0.dictionaryRepresentation() },
                                    requestUrl: selectedTab.requestUrl)
    }
    
    // MARK: - View Model instantiation -
    
    func movieShowCellViewModel(at indexPath: IndexPath) -> MovieShowCellViewModel? {
        guard indexPath.item < arrayMovieShows.count else {
            return nil
        }
        return MovieShowCellViewModel(object: arrayMovieShows[indexPath.item])
    }
    
    func movieShowDetailViewModel(at indexPath: IndexPath?) -> MovieShowDetailViewModel? {
        guard let indexPath = indexPath, indexPath.item < arrayMovieShows.count else {
            return nil
        }
        return MovieShowDetailViewModel(object: arrayMovieShows[indexPath.item], isMoviesTab: isMoviesTab)
    }
}
