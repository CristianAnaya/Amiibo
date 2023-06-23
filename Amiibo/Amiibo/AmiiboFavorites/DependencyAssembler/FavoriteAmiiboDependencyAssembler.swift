//
//  FavoriteAmiiboDependencyAssembler.swift
//  Amiibo
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 22/06/23.
//

import Foundation
import Swinject
import Domain

class FavoriteAmiiboDependencyAssembler: Assembly {
    
    func assemble(container: Container) {
        
        container.register(GetFavoriteAmiiboListUseCase.self) { resolver in
            GetFavoriteAmiiboListUseCase(amiiboRepository: container.resolve(AmiiboRepository.self)!)
        }
        .inObjectScope(.container)
        
        
        container.register(FavoriteAmiiboViewModel.self) { container in
            FavoriteAmiiboViewModel(
                getFavoriteAmiiboListUseCase: container.resolve(GetFavoriteAmiiboListUseCase.self)!
            )
        }
    }
    
}
