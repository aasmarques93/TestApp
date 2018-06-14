//
//  PagerViewModel.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/10/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

struct PagerViewModel: ViewModel {
    
    // MARK: - Objects -
    
    private var arrayTitles = [String]()
    var numberOfItems: Int { return arrayTitles.count }
    
    // MARK: - Variables -
    
    var firstItemWidth: CGFloat? {
        return arrayTitles.first?.width
    }
    
    // MARK: - Life cycle -
    
    init(titles: [String]) {
        arrayTitles = titles
    }
    
    // MARK: - ViewModel -
    
    func title(at indexPath: IndexPath?) -> String? {
        guard let indexPath = indexPath else {
            return arrayTitles.first
        }
        return arrayTitles[indexPath.item]
    }
}
