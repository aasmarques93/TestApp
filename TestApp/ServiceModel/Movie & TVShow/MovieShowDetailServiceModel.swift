//
//  MovieShowDetailServiceModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/9/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation

struct MovieShowDetailServiceModel: ServiceModel {
    func getDetail(from movie: MovieShow, handler: @escaping Handler<MovieShowDetail>) {
        request(requestUrl: .movie,
                urlParameters: createParameters(from: movie),
                handlerObject: { (object) in
                    
                    handler(MovieShowDetail.createObject(with: object))
        })
    }
    
    func getRelated(from movie: MovieShow, requestUrl: RequestUrl, handler: @escaping Handler<MovieShowsList>) {
        request(requestUrl: requestUrl,
                urlParameters: createParameters(from: movie),
                handlerObject: { (object) in
                    
                    handler(MovieShowsList.createObject(with: object))
        })
    }
    
    func createParameters(from movie: MovieShow) -> [String: Any] {
        var parameters = [String: Any]()
        parameters["idMovie"] = movie.id ?? 0
        parameters["page"] = 1
        parameters["language"] = Locale.preferredLanguages.first ?? ""
        return parameters
    }
}
