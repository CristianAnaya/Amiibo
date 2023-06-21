//
//  AmiiboDependencyAssembler.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import Foundation
import Swinject
import Domain
import CoreData

public class AmiiboDependencyAssembler: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        container.register(AmiiboDao.self) { container in
            return AmiiboDao(context: container.resolve(NSManagedObjectContext.self)!)
        }
        .inObjectScope(.container)
        
        container.register(AmiiboRemoteRepository.self) { container in
            AmiiboAlamofireRepository(httpClient: container.resolve(HttpClient.self)!)
        }
        .inObjectScope(.container)
        
        container.register(AmiiboLocalRepository.self) { container in
            AmiiboCoreDataRepository(dao: container.resolve(AmiiboDao.self)!)
        }
        .inObjectScope(.container)

        container.register(AmiiboRepository.self) { container in
            AmiiboProxy(
                amiiboLocalRepository: container.resolve(AmiiboLocalRepository.self)!,
                amiiboRemoteRepository: container.resolve(AmiiboRemoteRepository.self)!,
                networkVerify: container.resolve(NetworkVerify.self)!
            )
        }
        .inObjectScope(.container)
    }
    
}
