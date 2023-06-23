//
//  AmiiboDetailViewModel.swift
//  Amiibo
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 22/06/23.
//

import Foundation
import Domain
import Combine


final class AmiiboDetailViewModel: AmiiboDetailViewModelProtocol {
    
    private let getAmiiboDetailUseCase: GetAmiiboDetailUseCase
    private let saveAmiiboFavoriteUseCase: SaveAmiiboFavoriteUseCase
    private let head: String
    private let tail: String
    var cancellables: Set<AnyCancellable> = []
    
    @Published var isLoading: Bool = false
    @Published var amiibo: Amiibo?
    @Published var message: String? = nil
    
    init(
        getAmiiboDetailUseCase: GetAmiiboDetailUseCase,
        saveAmiiboFavoriteUseCase: SaveAmiiboFavoriteUseCase,
        head: String,
        tail: String
    ) {
        self.getAmiiboDetailUseCase = getAmiiboDetailUseCase
        self.saveAmiiboFavoriteUseCase = saveAmiiboFavoriteUseCase
        self.head = head
        self.tail = tail
    }
    
    func fetchAmiibo() {
        isLoading = true
        getAmiiboDetailUseCase.invoke(head: head, tail: tail)
            .sink { [weak self] completion in
                guard let self = self else { return }
                
                self.isLoading = false
                
                if case let .failure(error) = completion {
                    self.message = error.localizedDescription
                }
            } receiveValue: { [weak self] result in
                guard let self = self else { return }
                
                self.isLoading = false
                self.amiibo = result
            }
            .store(in: &cancellables)
    }
    
    
    func saveAmiibo() {
        guard let amiibo = amiibo else {
            message = "No hay un Amiibo válido"
            return
        }

        isLoading = true
         saveAmiiboFavoriteUseCase.invoke(amiibo: amiibo)
             .sink(receiveCompletion: { [weak self] completion in
                 guard let self = self else { return }
                 
                 self.isLoading = false
                 
                 switch completion {
                 case .failure(let error):
                     self.message = error.localizedDescription
                 case .finished:
                     self.message = "Se guardó correctamente" 
                     break
                 }
             }, receiveValue: { _ in })
             .store(in: &cancellables)
    }
}

