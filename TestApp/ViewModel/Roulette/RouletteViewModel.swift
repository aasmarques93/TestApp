//
//  RouletteViewModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/9/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Bond

class RouletteViewModel: ViewModel {
    // MARK: - Properties -
    
    // MARK: Delegate
    weak var delegate: ViewModelDelegate?
    
    // MARK: Service Model
    private let serviceModel = RouletteServiceModel()
    
    // MARK: Observable
    var genres = Observable<String?>(nil)
    
    var isMoviesOn = Observable<Bool>(true)
    var isTVShowsOn = Observable<Bool>(true)
    
    var isLabelMessageHidden = Observable<Bool>(false)
    var isViewResultHidden = Observable<Bool>(true)
    
    var titleResult = Observable<String?>(nil)
    var dateResult = Observable<String?>(nil)
    var movieShowType = Observable<String?>(nil)
    var overviewResult = Observable<String?>(nil)
    
    // MARK: Objects
    private var arrayGenres = [Genre]()
    
    private var arrayGenresTitles: [String] {
        var array = [Titles.allGenres.localized]
        let genres = arrayGenres.map { $0.name ?? "" }
        array.append(contentsOf: genres)
        return array
    }
    
    var imageResultUrl: URL? {
//        return URL(string: serviceModel.imageUrl(with: netflixRandomRoulette?.id, isMovie: isMovie))
        return nil
    }

    func loadData() {
        serviceModel.getGenres { [weak self] (results) in
            self?.arrayGenres = results
        }
    }

    func doSpin() {
//        let genres = arrayGenres.filter { $0.name == self.genres.value }        
    }
}
