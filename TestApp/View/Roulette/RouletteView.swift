//
//  RouletteView.swift
//  TestApp
//
//  Created by Arthur Augusto Sousa Marques on 6/9/18.
//  Copyright © 2018 Arthur Augusto. All rights reserved.
//

import UIKit
import Bond
import GhostTypewriter

class RouletteView: UIViewController {
    // MARK: - Outlets -
    
    @IBOutlet weak var labelMessage: TypewriterLabel!
    @IBOutlet weak var buttonSpin: UIButton!
    
    @IBOutlet weak var viewResult: UIView!
    
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var imageViewResult: UIImageView!
    @IBOutlet weak var labelTitleResult: UILabel!
    @IBOutlet weak var labelDateResult: UILabel!
    @IBOutlet weak var labelTypeResult: UILabel!
    @IBOutlet weak var textViewOverviewResult: UITextView!
    
    // MARK: - View Model -
    
    private let viewModel = RouletteViewModel()
    
    // MARK: - Life cycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = Titles.roulette.localized
        setupAppearance()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.delegate = self
        viewModel.loadData()
        labelMessage.startTypewritingAnimation(completion: nil)
    }
    
    // MARK: - Appearance -
    
    private func setupAppearance() {
        labelMessage.typingTimeInterval = 0.03
        buttonSpin.backgroundColor = HexColor.secondary.color
    }
    
    // MARK: - Bindings -
    
    private func setupBindings() {
        viewModel.isLabelMessageHidden.bind(to: labelMessage.reactive.isHidden)
        viewModel.isViewResultHidden.bind(to: viewResult.reactive.isHidden)
        viewModel.titleResult.bind(to: labelTitleResult.reactive.text)
        viewModel.dateResult.bind(to: labelDateResult.reactive.text)
        viewModel.movieShowType.bind(to: labelTypeResult.reactive.text)
        viewModel.overviewResult.bind(to: textViewOverviewResult.reactive.text)
    }
    
    // MARK: - Actions -
    
    @IBAction func buttonSpinAction(_ sender: UIButton) {
        viewModel.doSpin()
    }
    
    // MARK: - Segues -
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let viewController = segue.destination as? RouletteFilterView else {
            return
        }
        viewController.viewModel = viewModel
    }
}

extension RouletteView: ViewModelDelegate {
    // MARK: - View Model Delegate -
    
    func reloadData() {
        imageViewResult.sd_setImage(with: viewModel.imageResultUrl, placeholderImage: #imageLiteral(resourceName: "logo"))
        imageViewBackground.sd_setImage(with: viewModel.imageResultUrl, placeholderImage: #imageLiteral(resourceName: "logo"))
    }
    
    func showAlert(message: String?) {
        alertController?.show(message: message)
    }
}
