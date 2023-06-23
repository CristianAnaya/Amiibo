//
//  AmiiboHome.swift
//  Amiibo
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 22/06/23.
//

import Foundation
import Swinject
import Domain

class AmiiboHomeDependencyAssembler: Assembly {
    
    func assemble(container: Container) {
        
        container.register(GetAmiiboListUseCase.self) { resolver in
            GetAmiiboListUseCase(amiiboRepository: container.resolve(AmiiboRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(FilterAmiiboByTypeUseCase.self) { resolver in
            FilterAmiiboByTypeUseCase(amiiboRepository: container.resolve(AmiiboRepository.self)!)
        }
        .inObjectScope(.container)
        
        container.register(AmiiboHomeViewModel.self) { container in
            AmiiboHomeViewModel(
                getAmiiboListUseCase: container.resolve(GetAmiiboListUseCase.self)!,
                filterAmiiboByTypeUseCase: container.resolve(FilterAmiiboByTypeUseCase.self)!
            )
        }
    }
    
}
