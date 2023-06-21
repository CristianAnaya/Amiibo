//
//  AmiiboDatabaseAssembler.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation
import Swinject
import CoreData

public final class AmiiboDatabaseAssembler: Assembly {
    
    public init() {}
    
    public func assemble(container: Container) {
        let amiibo = Bundle.main.object(forInfoDictionaryKey: "AmiiboDatabase") as! String
        container.register(NSManagedObjectContext.self) { _ in
            let amiiboDatabase = AmiiboDatabase(modelName: amiibo)
            return amiiboDatabase.managedContext
        }
        .inObjectScope(.container)
    }
    
}
