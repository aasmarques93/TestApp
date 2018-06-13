//
//  MovieShowsContainerViewModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/10/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

enum MovieShowTab: String {
    // Movies
    case popular
    case nowPlaying
    case topRated
    case upcoming
    
    // TV Shows
    case airingToday
    case onTheAir
    case popularShow
    case topRatedShow
    
    static var movies: [MovieShowTab] = [.popular, .nowPlaying, .topRated, .upcoming]
    static var shows: [MovieShowTab] = [.airingToday, .onTheAir, .popularShow, .topRatedShow]
}

extension MovieShowTab {
    var localized: String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
    
    var requestUrl: RequestUrl {
        switch self {
        case .popular:
            return .popular
        case .nowPlaying:
            return .nowPlaying
        case .topRated:
            return .topRated
        case .upcoming:
            return .upcoming
        case .airingToday:
            return .tvAiringToday
        case .onTheAir:
            return .tvOnTheAir
        case .popularShow:
            return .tvPopular
        case .topRatedShow:
            return .tvTopRated
        }
    }
}

struct MovieShowsContainerViewModel: ViewModel {
    // MARK: - Objects -
    private var arrayTabs: [MovieShowTab] {
        return isMoviesTab ? MovieShowTab.movies : MovieShowTab.shows
    }
    var numberOfTabs: Int { return arrayTabs.count }
    
    var titles: [String] { return arrayTabs.map { $0.localized } }
    
    // MARK: Variables
    private var isMoviesTab: Bool

    // MARK: - Life Cycle -
    init(isMoviesTab: Bool) {
        self.isMoviesTab = isMoviesTab
    }
    
    // MARK: - View Model instantiation -
    func movieShowsViewModel(at index: Int) -> MovieShowsViewModel? {
        return MovieShowsViewModel(selectedTab: arrayTabs[index], isMoviesTab: isMoviesTab)
    }
    
    func pagerViewModel() -> PagerViewModel {
        return PagerViewModel(titles: titles)
    }
}
