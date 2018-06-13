//
//  RouletteServiceModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/9/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import SwiftyJSON

struct RouletteServiceModel: ServiceModel {
    func getGenres(handler: @escaping Handler<[Genre]>) {
        request(requestUrl: .genres, handlerObject: { (object) in
            guard let array = object as? [JSON] else {
                handler([])
                return
            }
            
            var arrayGenres = [Genre]()
            array.forEach { (genre) in
                arrayGenres.append(Genre(object: genre))
            }
            handler(arrayGenres)
        })
    }
}
