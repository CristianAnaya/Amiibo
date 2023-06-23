//
//  FavoriteAmiiboViewController.swift
//  Amiibo
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 22/06/23.
//

import UIKit

class FavoriteAmiiboViewController: UIViewController {

    // UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private var viewModel: FavoriteAmiiboViewModel = DependencyInjectionContainer.shared.resolve(FavoriteAmiiboViewModel.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel.fetchFavoritesAmiibo()
    }
    
    private func setupView(status: Bool) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isHidden = status
        activityIndicatorView.isHidden = !status
    }
        
    private func bindViewModel() {
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isLoading in
                self?.setupView(status: isLoading)
                isLoading ? self?.activityIndicatorView.startAnimating() : self?.activityIndicatorView.stopAnimating()
            }
            .store(in: &viewModel.cancellables)
        
        viewModel.$favoriteAmiiboList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &viewModel.cancellables)
        
        viewModel.$errorMessage
            .receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let message = errorMessage else { return }
                self?.showMessage(message: message, font: .systemFont(ofSize: 12.0))
            }
            .store(in: &viewModel.cancellables)
    }
    
}

extension FavoriteAmiiboViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let amiiboDetailVC = storyboard.instantiateViewController(withIdentifier: "AmiiboDetailViewController") as? AmiiboDetailViewController else {
                return
        }
        let amiibo = viewModel.favoriteAmiiboList[indexPath.row]
        amiiboDetailVC.viewModel = DependencyInjectionContainer.shared.resolve(
            AmiiboDetailViewModel.self,
            argument: amiibo.head,
            argument: amiibo.tail
        )
        navigationController?.pushViewController(amiiboDetailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoriteAmiiboList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AmiiboTableViewCell
        let amiibo = viewModel.favoriteAmiiboList[indexPath.row]
        
        cell.setCellWithValuesOf(amiibo)
        
        return cell
    }
    
}
