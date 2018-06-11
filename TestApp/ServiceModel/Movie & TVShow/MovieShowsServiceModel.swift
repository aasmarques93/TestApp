//
//  MovieShowServiceModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/9/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

struct MovieShowsServiceModel: ServiceModel {
    func getMovieShows(requestUrl: RequestUrl, urlParameters: [String: Any]? = nil, handler: @escaping Handler<MovieShowsList>) {
        request(requestUrl: requestUrl, urlParameters: urlParameters, handlerObject: { (object) in
            handler(MovieShowsList.createObject(with: object))
        })
    }
    
    func doSearch(urlParameters: [String: Any], handler: @escaping Handler<MovieShowsList>) {
        request(requestUrl: .searchTV, urlParameters: urlParameters, handlerObject: { (object) in
            handler(MovieShowsList.createObject(with: object))
        })
    }
}
