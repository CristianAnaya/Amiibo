//
//  DependencyInjectionContainer.swift
//  Amiibo
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 22/06/23.
//

import Foundation
import Swinject
import Infrastructure

final class DependencyInjectionContainer {
    static let shared = DependencyInjectionContainer()

    let assembler: Assembler
    
    init() {
        assembler = Assembler(
            [
                AmiiboDependencyInjection(),
                ProvidesDependencyInjection()
            ]
        )
    }
        
    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return assembler.resolver.resolve(serviceType)
    }
    
    func resolve<Service>(_ serviceType: Service.Type, argument arg1: String, argument arg2: String) -> Service? {
        return assembler.resolver.resolve(serviceType, arguments: arg1, arg2)
    }
}
