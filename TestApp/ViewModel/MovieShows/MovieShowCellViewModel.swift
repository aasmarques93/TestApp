//
//  MovieShowCellViewModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 7/31/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Bond

struct MovieShowCellViewModel: ViewModel {
    // MARK: - Properties -
    
    // MARK: Observables
    var title = Observable<String?>(nil)
    var average = Observable<String?>(nil)
    
    // MARK: Service Model
    private let serviceModel = MovieShowsServiceModel()
    
    // MARK: Objects
    private var movieShow: MovieShow

    // MARK: Variables
    var imagePathUrl: URL? {
        return URL(string: serviceModel.imageUrl(with: movieShow.posterPath))
    }
    
    // MARK: - Life cycle -
    
    init(object: MovieShow) {
        movieShow = object
    }
    
    // MARK: - View Model -
    
    func loadData() {
        title.value = movieShow.title ?? movieShow.originalName
        guard let voteAverage = movieShow.voteAverage else {
            return
        }
        average.value = "☆ \(voteAverage)"
    }
}
