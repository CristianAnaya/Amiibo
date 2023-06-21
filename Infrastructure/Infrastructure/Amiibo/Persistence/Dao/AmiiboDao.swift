//
//  AmiiboDao.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation
import CoreData
import Combine

public class AmiiboDao: BaseDao {
    
    typealias T = AmiiboEntity
    
    let context: NSManagedObjectContext
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    func fetchAll() -> AnyPublisher<[AmiiboEntity], Error> {
        return Future<[AmiiboEntity], Error> { promise in
            self.context.perform {
                do {
                    guard let entityName = T.entity().name else {
                        throw TechnicalException.technicalError
                    }
                    let request = NSFetchRequest<T>(entityName: entityName)
                    let results = try self.context.fetch(request)
                    promise(.success(results))
                } catch {
                    self.context.rollback()
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func fetchOne(id: Int) -> AnyPublisher<AmiiboEntity?, Error> {
        return Future<AmiiboEntity?, Error> { promise in
            self.context.perform {
                do {
                    guard let entityName = T.entity().name else {
                        throw TechnicalException.technicalError
                    }
                    let request = NSFetchRequest<T>(entityName: entityName)
                    let predicate = NSPredicate(format: "id == %d", id)
                    request.predicate = predicate
                    request.fetchLimit = 1
                    let results = try self.context.fetch(request)
                    promise(.success(results.first))
                } catch {
                    self.context.rollback()
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func count() -> AnyPublisher<Int, Error> {
        return Future<Int, Error> { promise in
            self.context.perform {
                do {
                    guard let entityName = T.entity().name else {
                        throw TechnicalException.technicalError
                    }
                    let request = NSFetchRequest<T>(entityName: entityName)
                    let count = try self.context.count(for: request)
                    promise(.success(count))
                } catch {
                    promise(.failure(error))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func count(predicate: NSPredicate) -> AnyPublisher<Int, Error> {
        return Future<Int, Error> { promise in
            self.context.perform {
                do {
                    guard let entityName = T.entity().name else {
                        throw TechnicalException.technicalError
                    }
                    let request = NSFetchRequest<T>(entityName: entityName)
                    request.predicate = predicate
                    let count = try self.context.count(for: request)
                    promise(.success(count))
                } catch {
                    promise(.failure(error))
                }
            }
            
        }.eraseToAnyPublisher()
    }
    
    func delete(_ object: AmiiboEntity) throws {
        try context.performAndWait {
            do {
                self.context.delete(object)
                try self.context.save()
            } catch {
                self.context.rollback()
                throw error
            }
        }
    }
    
    func insertAll(data: [AmiiboEntity]) throws {
        try context.performAndWait {
            do {
                try self.context.save()
            } catch {
                self.context.rollback()
                throw error
            }
        }
    }
    
}
