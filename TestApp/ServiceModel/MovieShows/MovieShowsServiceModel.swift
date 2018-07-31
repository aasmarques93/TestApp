//
//  MovieShowServiceModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 8/1/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation

struct MovieShowsServiceModel: ServiceModel {
    func getMovieShows(requestUrl: RequestUrl,
                       urlParameters: [String: Any]? = nil,
                       handler: @escaping Handler<MovieShowsList>) {
        
        request(requestUrl: requestUrl, urlParameters: urlParameters, handlerObject: { (object) in
            handler(MovieShowsList(object: object))
        })
    }
}
