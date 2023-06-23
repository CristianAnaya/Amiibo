//
//  AmiiboFavoritesViewModel.swift
//  Amiibo
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 22/06/23.
//

import Foundation
import Combine
import Domain

final class FavoriteAmiiboViewModel: FavoriteAmiiboViewModelProtocol {
 
    private let getFavoriteAmiiboListUseCase: GetFavoriteAmiiboListUseCase
    var cancellables: Set<AnyCancellable> = []
    
    @Published var isLoading: Bool = false
    @Published var favoriteAmiiboList: [Amiibo] = []
    @Published var errorMessage: String? = nil
    
    init(getFavoriteAmiiboListUseCase: GetFavoriteAmiiboListUseCase) {
        self.getFavoriteAmiiboListUseCase = getFavoriteAmiiboListUseCase
    }
    
    func fetchFavoritesAmiibo() {
        isLoading = true

        do {
            try getFavoriteAmiiboListUseCase.invoke()
                .sink { [weak self] completion in
                    guard let self = self else { return }
                    
                    self.isLoading = false
                    
                    if case let .failure(error) = completion {
                        self.errorMessage = error.localizedDescription
                    }
                } receiveValue: { [weak self] favoriteAmiiboList in
                    guard let self = self else { return }
                    
                    self.isLoading = false
                    self.favoriteAmiiboList = favoriteAmiiboList
                }
                .store(in: &cancellables)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
}
