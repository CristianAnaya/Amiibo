//
//  AmiiboDetailDependencyAssembler.swift
//  Amiibo
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 22/06/23.
//

import Swinject
import Domain

class AmiiboDetailDependencyAssembler: Assembly {
    
    func assemble(container: Container) {
        
        container.register(GetAmiiboDetailUseCase.self) { resolver in
            GetAmiiboDetailUseCase(amiiboRepository: container.resolve(AmiiboRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(SaveAmiiboFavoriteUseCase.self) { resolver in
            SaveAmiiboFavoriteUseCase(amiiboRepository: container.resolve(AmiiboRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(AmiiboDetailViewModel.self) { (container, head: String, tail: String ) in
            AmiiboDetailViewModel(
                getAmiiboDetailUseCase: container.resolve(GetAmiiboDetailUseCase.self)!,
                saveAmiiboFavoriteUseCase: container.resolve(SaveAmiiboFavoriteUseCase.self.self)!,
                head: head,
                tail: tail
            )
        }
    }
    
}
