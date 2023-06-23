//
//  ProvidesDependencyInjection.swift
//  Amiibo
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 22/06/23.
//

import Swinject
import Infrastructure

final class ProvidesDependencyInjection: Assembly {
    
    func assemble(container: Container) {
        let assemblies: [Assembly] = [
            HttpClientAssembler(),
            NetworkVerifyAssembler(),
            AmiiboDatabaseAssembler()
        ]
        
        assemblies.forEach { $0.assemble(container: container) }
    }
}

