//
//  PagerView.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/10/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit

protocol PagerViewDelegate: class {
    func didSelect(at indexPath: IndexPath)
}

private let margin: CGFloat = 8
private let viewIndicatorBottomSpace: CGFloat = 4
private let itemHeight: CGFloat = 40
private let itemWidth: CGFloat = 144

class PagerView: UIViewController {
    
    // MARK: - Outlets -
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet var viewIndicator: UIView!
    
    // MARK: - Delegate -
    
    weak var delegate: PagerViewDelegate?
    
    // MARK: - View Model -
    
    var viewModel: PagerViewModel?
    
    // MARK: - Properties -
    
    var currentIndexPath: IndexPath?
    
    // MARK: - Life cycle -
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
    }
    
    func reloadData() {
        addViewIndicator()
        collectionView.reloadData()
    }
    
    // MARK: - Appearance -
    
    private func addViewIndicator() {
        viewIndicator.removeFromSuperview()
        
        let width = viewModel?.title(at: currentIndexPath)?.width ?? itemWidth
        viewIndicator.frame = CGRect(x: viewIndicator.frame.minX == 0 ? margin : viewIndicator.frame.minX,
                                     y: itemHeight - viewIndicatorBottomSpace,
                                     width: width + margin,
                                     height: viewIndicator.frame.height)
        
        collectionView.addSubview(viewIndicator)
    }
    
    // MARK: - Pager Methods -
    
    func selectItem(at indexPath: IndexPath, animated: Bool = true) {
        currentIndexPath = indexPath
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: animated)
        
        let cell = collectionView.dequeueReusableCell(PagerViewCell.self, for: indexPath)
        cell.labelTitle.textColor = UIColor(colorStyle: .secondary)
        collectionView.reloadData()

        let rect = CGRect(x: cell.frame.minX,
                          y: viewIndicator.frame.minY,
                          width: cell.frame.width,
                          height: viewIndicator.frame.height)
        
        if animated {
            UIView.animate(withDuration: 0.3, animations: {
                self.changeFrame(rect)
            })
        } else {
            changeFrame(rect)
        }
    }
    
    private func changeFrame(_ rect: CGRect) {
        viewIndicator.frame = rect
    }
}

extension PagerView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItems ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if currentIndexPath == nil { currentIndexPath = indexPath }

        let cell = collectionView.dequeueReusableCell(PagerViewCell.self, for: indexPath)
        cell.viewModel = viewModel
        cell.setupView(at: indexPath)
        cell.labelTitle.textColor = indexPath == currentIndexPath ? UIColor(colorStyle: .secondary) : UIColor(colorStyle: .text)
        return cell
    }
}

extension PagerView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard currentIndexPath != indexPath else {
            return
        }
        delegate?.didSelect(at: indexPath)
        selectItem(at: indexPath)
    }
}

extension PagerView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let title = viewModel?.title(at: indexPath) ?? ""
        return CGSize(width: title.width + margin, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(0, margin, 0, margin)
    }
}
