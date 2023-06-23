//
//  AmiiboHomeView.swift
//  Amiibo
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 22/06/23.
//

import UIKit

class AmiiboHomeViewController: UIViewController {
    
    // UI
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    private var viewModel: AmiiboHomeViewModel = DependencyInjectionContainer.shared.resolve(AmiiboHomeViewModel.self)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchTextField.delegate = self
        viewModel.fetchAmiiboList()
        bindViewModel()
    }
    
    private func setupView(status: Bool) {
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
        
        viewModel.$amiiboList
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

extension AmiiboHomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchAmiiboByType()
        return true
    }
    
    func searchAmiiboByType() {
        searchTextField.resignFirstResponder()
        
        guard let text = searchTextField.text, !text.isEmpty else {
            return
        }
        
        viewModel.filterAmiiboByType(type: text)
    }
}

extension AmiiboHomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let amiiboDetailVC = storyboard.instantiateViewController(withIdentifier: "AmiiboDetailViewController") as? AmiiboDetailViewController else {
                return
        }
        let amiibo = viewModel.amiiboList[indexPath.row]
        amiiboDetailVC.viewModel = DependencyInjectionContainer.shared.resolve(
            AmiiboDetailViewModel.self,
            argument: amiibo.head,
            argument: amiibo.tail
        )
        navigationController?.pushViewController(amiiboDetailVC, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.amiiboList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AmiiboTableViewCell
        let amiibo = viewModel.amiiboList[indexPath.row]
        
        cell.setCellWithValuesOf(amiibo)
        
        return cell
    }
    
}

