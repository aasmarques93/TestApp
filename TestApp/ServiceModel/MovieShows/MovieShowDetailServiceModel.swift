//
//  MovieShowDetailServiceModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/9/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Foundation

struct MovieShowDetailServiceModel: ServiceModel {
    func getDetail(from movieShow: MovieShow, requestUrl: RequestUrl, handler: @escaping Handler<MovieShowDetail>) {
        request(requestUrl: requestUrl,
                urlParameters: createParameters(from: movieShow),
                handlerObject: { (object) in
                    
                    handler(MovieShowDetail(object: object))
        })
    }
    
    func getRelated(from movieShow: MovieShow, requestUrl: RequestUrl, handler: @escaping Handler<MovieShowsList>) {
        request(requestUrl: requestUrl,
                urlParameters: createParameters(from: movieShow),
                handlerObject: { (object) in
                    
                    handler(MovieShowsList(object: object))
        })
    }
    
    func createParameters(from movieShow: MovieShow) -> [String: Any] {
        var parameters = [String: Any]()
        parameters["id"] = movieShow.id ?? 0
        parameters["idMovie"] = movieShow.id ?? 0
        parameters["page"] = 1
        parameters["language"] = Locale.preferredLanguages.first ?? ""
        return parameters
    }
}
