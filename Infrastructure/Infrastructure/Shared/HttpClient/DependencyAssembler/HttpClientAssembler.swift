//
//  HttpClientAssembler.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Swinject

public final class HttpClientAssembler: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
    
        container.register(HttpClient.self) { _ in
            HttpClient()
        }
        .inObjectScope(.container)
    }
    
}
