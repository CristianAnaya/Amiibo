//
//  AmiiboDependencyInjection.swift
//  Amiibo
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 22/06/23.
//

import Foundation
import Infrastructure
import Swinject

final class AmiiboDependencyInjection: Assembly {
    func assemble(container: Container) {
        let assembies: [Assembly] = [
            AmiiboHomeDependencyAssembler(),
            FavoriteAmiiboDependencyAssembler(),
            AmiiboDetailDependencyAssembler(),
            AmiiboDependencyAssembler()
        ]
        
        assembies.forEach { $0.assemble(container: container) }
    }
}
