//
//  MovieShowDetailViewModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 8/1/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Bond

protocol MovieShowDetailViewModelDelegate: ViewModelDelegate {
    func reloadRecommendedMovieShows()
}

class MovieShowDetailViewModel: ViewModel, LoadingProtocol {
    
    // MARK: - Properties -
    
    internal var loading: Loading = Loading()
    
    // MARK: Delegate
    weak var delegate: MovieShowDetailViewModelDelegate?
    
    // MARK: Service Model
    private let serviceModel = MovieShowDetailServiceModel()
    
    // MARK: Observables
    var title = Observable<String?>(nil)
    var date = Observable<String?>(nil)
    var runtime = Observable<String?>(nil)
    var genres = Observable<String?>(nil)
    var overview = Observable<String?>(nil)
    
    // MARK: Objects
    private var movieShow: MovieShow
    
    private var movieShowDetail: MovieShowDetail? {
        didSet {
            delegate?.reloadData?()
            
            title.value = movieShowDetail?.title ?? movieShowDetail?.originalName
            date.value = valueDescription(movieShowDetail?.releaseDate)
            runtime.value = "\(valueDescription(movieShowDetail?.runtime)) minutes"
            overview.value = valueDescription(movieShowDetail?.overview)
            
            genres.value = setupGenres()
        }
    }
    
    
    // MARK: Variables
    private var isMoviesTab: Bool

    var average: CGFloat {
        return CGFloat(movieShowDetail?.voteAverage ?? 0) / 10
    }
    var isDetailEmpty: Bool {
        return movieShowDetail == nil
    }
    var imageUrl: URL? {
        return URL(string: serviceModel.imageUrl(with: movieShow.backdropPath ?? ""))
    }
    var movieShowTitle: String? {
        return movieShow.title ?? movieShow.originalName
    }
    
    // MARK: Recommended
    private var arrayRecommendedMovieShows = [MovieShow]() { didSet { delegate?.reloadRecommendedMovieShows() } }
    var numberOfRecommendedMovieShows: Int { return arrayRecommendedMovieShows.count }
    
    // MARK: - Life cycle -
    
    init(object: MovieShow, isMoviesTab: Bool) {
        self.movieShow = object
        self.isMoviesTab = isMoviesTab
    }
    
    // MARK: - Service requests -
    
    func loadData() {
        getMovieShowDetail()
        getRecommendedMovieShows()
    }
    
    private func getMovieShowDetail() {
        loading.start()
        let requestUrl: RequestUrl = isMoviesTab ? .movie : .tvShow
        serviceModel.getDetail(from: movieShow, requestUrl: requestUrl) { [weak self] (object) in
            self?.loading.stop()
            self?.movieShowDetail = object
        }
    }
    
    private func getRecommendedMovieShows() {
        let requestUrl: RequestUrl = isMoviesTab ? .recommendations : .tvRecommendations
        serviceModel.getRelated(from: movieShow, requestUrl: requestUrl) { [weak self] (object) in
            guard let results = object.results else {
                return
            }
            self?.arrayRecommendedMovieShows.append(contentsOf: results)
        }
    }
    
    // MARK: - View Model -
    
    private func setupGenres() -> String {
        guard let array = movieShowDetail?.genres else {
            return ""
        }
        
        var string = ""
        let arrayNames = array.map { valueDescription($0.name) }
        string = arrayNames.joined(separator: ", ")
        return string
    }
    
    // MARK: Recommendations
    
    func movieShowRecommendedImageUrl(at index: Int) -> URL? {
        let movieShow = arrayRecommendedMovieShows[index]
        return URL(string: serviceModel.imageUrl(with: movieShow.posterPath ?? ""))
    }
    
    // MARK: - View Model Instantiation -
    
    func recommendedMovieShowDetailViewModel(at index: Int) -> MovieShowDetailViewModel? {
        return MovieShowDetailViewModel(object: arrayRecommendedMovieShows[index], isMoviesTab: isMoviesTab)
    }
}
