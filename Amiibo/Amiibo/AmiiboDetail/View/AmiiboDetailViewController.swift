//
//  AmiiboDetailViewController.swift
//  Amiibo
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 22/06/23.
//

import UIKit
import Domain

class AmiiboDetailViewController: UIViewController {

    // MARK: - UI
    @IBOutlet weak var blueView: UIView!
    @IBOutlet var dataView: UIView!
    @IBOutlet weak var addFavoriteButton: UIButton!
    @IBOutlet weak var figureNameLabel: UILabel!
    @IBOutlet weak var imageView: CustomImageView!
    @IBOutlet weak var amiiboCharacterLabel: UILabel!
    @IBOutlet weak var naReleaseLabel: UILabel!
    @IBOutlet weak var jpReleaseLabel: UILabel!
    @IBOutlet weak var euReleaseLabel: UILabel!
    @IBOutlet weak var auReleaseLabel: UILabel!
    @IBOutlet weak var amiiboSeriesLabel: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var viewModel: AmiiboDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        blueView.layer.cornerRadius = 20
        setupView(status: true)
        viewModel.fetchAmiibo()
        bindViewModel()
    }
    
    @IBAction func saveFavoriteAmiibo(_ sender: Any) {
        viewModel.saveAmiibo()
    }
    
    private func bindViewModel() {
        viewModel?.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.activityIndicator.isHidden = !isLoading
                isLoading ? self?.activityIndicator.startAnimating() : self?.activityIndicator.stopAnimating()
            }
            .store(in: &viewModel.cancellables)
        
        viewModel?.$amiibo
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let amiibo = result else { return }
                self?.setupView(status: false)
                self?.setupUI(amiibo: amiibo)
            }
            .store(in: &viewModel.cancellables)
        
        viewModel?.$message
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let message = errorMessage else { return }
                self?.showMessage(message: message, font: .systemFont(ofSize: 12.0))
            }
            .store(in: &viewModel.cancellables)
    }
    
    private func setupView(status: Bool) {
        blueView.isHidden = status
        addFavoriteButton.isHidden = status
        imageView.isHidden = status
    }
    
    private func setupUI(amiibo: Amiibo) {
        figureNameLabel.text = amiibo.name
        amiiboCharacterLabel.text = amiibo.character
        amiiboSeriesLabel.text = amiibo.amiiboSeries
        naReleaseLabel.text = "NA:" + (amiibo.release.formattedNA)
        euReleaseLabel.text = "EU:" + (amiibo.release.formattedEU)
        jpReleaseLabel.text = "JP:" + (amiibo.release.formattedJP)
        auReleaseLabel.text = "AU:" + (amiibo.release.formattedAU)
        
        if let url = URL(string: amiibo.image) {
            DispatchQueue.global().async {
                if let imageData = try? Data(contentsOf: url),
                   let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self.imageView.image = image
                    }
                }
            }
        }

    }

}
