//
//  MovieShowDetailViewModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/9/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Bond

protocol MovieShowDetailViewModelDelegate: ViewModelDelegate {
    func reloadRecommendedMovies()
    func reloadSimilarMovies()
}

class MovieShowDetailViewModel: ViewModel {
    // MARK: - Properties -
    
    // MARK: Delegate
    weak var delegate: MovieShowDetailViewModelDelegate?
    
    // MARK: Service Model
    private let serviceModel = MovieShowDetailServiceModel()
    
    // MARK: Observables
    var name = Observable<String?>(nil)
    var average = Observable<String?>(nil)
    var date = Observable<String?>(nil)
    var runtime = Observable<String?>(nil)
    var genres = Observable<String?>(nil)
    var overview = Observable<String?>(nil)
    
    // MARK: Objects
    private var movie: MovieShow
    
    private var movieDetail: MovieShowDetail? {
        didSet {
            delegate?.reloadData?()
            
            name.value = valueDescription(movieDetail?.title)
            date.value = valueDescription(movieDetail?.releaseDate)
            average.value = valueDescription(movieDetail?.voteAverage)
            runtime.value = "\(valueDescription(movieDetail?.runtime)) minutes"
            overview.value = valueDescription(movieDetail?.overview)
            
            genres.value = setupGenres()
        }
    }
    
    var imageUrl: URL? {
        return URL(string: serviceModel.imageUrl(with: movie.backdropPath ?? ""))
    }
    
    // MARK: Recommended
    private var arrayRecommendedMovies = [MovieShow]() { didSet { delegate?.reloadRecommendedMovies() } }
    var numberOfRecommendedMovies: Int { return arrayRecommendedMovies.count }
    
    // MARK: Similar Movies
    private var arraySimilarMovies = [MovieShow]() { didSet { delegate?.reloadSimilarMovies() } }
    var numberOfSimilarMovies: Int { return arraySimilarMovies.count }
    
    // MARK: - Life cycle -
    
    init(_ object: MovieShow) {
        self.movie = object
    }
    
    // MARK: - Service requests -
    
    func loadData() {
        getMovieDetail()
        getRecommendedMovies()
        getSimilarMovies()
    }
    
    private func getMovieDetail() {
        serviceModel.getDetail(from: movie) { [weak self] (object) in
            self?.movieDetail = object
        }
    }
    
    private func getRecommendedMovies() {
        guard arrayRecommendedMovies.isEmpty else {
            return
        }
        
        serviceModel.getRelated(from: movie, requestUrl: .recommendations) { [weak self] (object) in
            guard let results = object.results else {
                return
            }
            
            self?.arrayRecommendedMovies.append(contentsOf: results)
        }
    }
    
    private func getSimilarMovies() {
        guard arraySimilarMovies.isEmpty else {
            return
        }
        
        serviceModel.getRelated(from: movie, requestUrl: .similar) { [weak self] (object) in
            guard let results = object.results else {
                return
            }
            
            self?.arraySimilarMovies.append(contentsOf: results)
        }
    }
    
    // MARK: - View Model -
    
    // MARK: Movie
    
    var movieName: String? {
        return movie.title
    }
    
    private func setupGenres() -> String {
        var string = ""
        if let array = movieDetail?.genres {
            let arrayNames = array.map { valueDescription($0.name) }
            string = arrayNames.joined(separator: ", ")
        }
        return string
    }
    
    // MARK: Recommendations
    
    func movieRecommendationImageUrl(at index: Int) -> URL? {
        let movie = arrayRecommendedMovies[index]
        return URL(string: serviceModel.imageUrl(with: movie.posterPath ?? ""))
    }
    
    // MARK: Similar
    
    func similarMovieImageUrl(at index: Int) -> URL? {
        let movie = arraySimilarMovies[index]
        return URL(string: serviceModel.imageUrl(with: movie.posterPath ?? ""))
    }

    // MARK: - View Model Instantiation -
    
    func recommendedMovieShowDetailViewModel(at index: Int) -> MovieShowDetailViewModel? {
        return movieShowDetailViewModel(arrayRecommendedMovies[index])
    }
    
    func similarMovieShowDetailViewModel(at index: Int) -> MovieShowDetailViewModel? {
        return movieShowDetailViewModel(arraySimilarMovies[index])
    }
    
    private func movieShowDetailViewModel(_ movieShow: MovieShow) -> MovieShowDetailViewModel? {
        return MovieShowDetailViewModel(movieShow)
    }
}
