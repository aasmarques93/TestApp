//
//  ExploreServiceModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/13/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

struct ExploreServiceModel: ServiceModel {
    func getGenres(handler: @escaping Handler<GenresList>) {
        let parameters: [String: Any] = [
            "language": Locale.preferredLanguages.first ?? ""
        ]
        request(requestUrl: .genres, urlParameters: parameters, handlerObject: { (object) in
            handler(GenresList(object: object))
        })
    }
}
