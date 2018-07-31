//
//  ExploreCellViewModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 8/1/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import Bond

class ExploreCellViewModel: ViewModel {
    // MARK: - Properties -
    
    // MARK: Observables
    
    var image = Observable<UIImage?>(nil)
    var title = Observable<String?>(nil)
    
    // MARK: Object
    
    var genre: Genre
    
    // MARK: - Life cycle -
    
    init(object: Genre) {
        genre = object
    }
    
    // MARK: - Load data -
    
    func loadData() {
        image.value = UIImage(named: genre.name?.replacingOccurrences(of: " ", with: "") ?? "")
        title.value = genre.name
    }
}
