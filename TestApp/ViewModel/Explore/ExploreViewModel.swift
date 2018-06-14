//
//  ExploreViewModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/13/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

class ExploreViewModel: ViewModel, LoadingProtocol {
    // MARK: - Properties -
    
    internal var loading: Loading = Loading()
    
    // MARK: Delegate
    weak var delegate: ViewModelDelegate?
    
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
    
    // MARK: - View Model -
    
    func exploreCellViewModel(at indexPath: IndexPath) -> ExploreCellViewModel {
        return ExploreCellViewModel(object: arrayGenres[indexPath.row])
    }
    
    func movieShowsViewModel(at indexPath: IndexPath) -> MovieShowsViewModel {
        return MovieShowsViewModel(selectedTab: .searchByGenre, isMoviesTab: true, genre: arrayGenres[indexPath.row])
    }
}
