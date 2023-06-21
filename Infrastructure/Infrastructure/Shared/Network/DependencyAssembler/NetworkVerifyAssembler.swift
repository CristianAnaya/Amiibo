//
//  NetworkVerifyAssembler.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation
import Swinject

public final class NetworkVerifyAssembler: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(NetworkVerify.self) { _ in
            NetworkVerify()
        }
        .inObjectScope(.container)
    }
    
}
