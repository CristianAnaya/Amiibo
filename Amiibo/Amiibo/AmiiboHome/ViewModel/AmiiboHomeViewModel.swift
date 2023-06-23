//
//  AmiiboHomeViewModel.swift
//  Amiibo
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 22/06/23.
//

import Foundation
import Combine
import Domain

final class AmiiboHomeViewModel: AmiiboHomeViewModelProtocol {

    private let getAmiiboListUseCase: GetAmiiboListUseCase
    private let filterAmiiboByTypeUseCase: FilterAmiiboByTypeUseCase
    
    var cancellables: Set<AnyCancellable> = []
    
    @Published var isLoading: Bool = false
    @Published var amiiboList: [Amiibo] = []
    @Published var errorMessage: String? = nil
    
    init(getAmiiboListUseCase: GetAmiiboListUseCase, filterAmiiboByTypeUseCase: FilterAmiiboByTypeUseCase) {
        self.getAmiiboListUseCase = getAmiiboListUseCase
        self.filterAmiiboByTypeUseCase = filterAmiiboByTypeUseCase
    }
    
    func fetchAmiiboList() {
        isLoading = true

        getAmiiboListUseCase.invoke()
            .sink { [weak self] completion in
                guard let self = self else { return }

                self.isLoading = false

                if case let .failure(error) = completion {
                    self.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] amiiboList in
                guard let self = self else { return }

                self.isLoading = false
                self.amiiboList = amiiboList
            }
            .store(in: &cancellables)
    }
    
    func filterAmiiboByType(type: String) {
        isLoading = true

        do {
            try filterAmiiboByTypeUseCase.invoke(type: type)
                .sink { [weak self] completion in
                    guard let self = self else { return }
                    
                    self.isLoading = false
                    
                    if case let .failure(error) = completion {
                        self.errorMessage = error.localizedDescription
                    }
                } receiveValue: { [weak self] amiiboList in
                    guard let self = self else { return }
                    
                    self.isLoading = false
                    self.amiiboList = amiiboList
                }
                .store(in: &cancellables)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
}
