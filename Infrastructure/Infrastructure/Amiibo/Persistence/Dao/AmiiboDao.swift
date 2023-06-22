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
                    let fetchRequest: NSFetchRequest<AmiiboEntity> = AmiiboEntity.fetchRequest()
                    fetchRequest.relationshipKeyPathsForPrefetching = ["amiiboRelease"]
                    let results = try self.context.fetch(fetchRequest)
                    promise(.success(results))
                } catch {
                    self.context.rollback()
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func delete(head: String, tail: String) -> AnyPublisher<Void, Error> {
        let fetchRequest: NSFetchRequest<AmiiboEntity> = AmiiboEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "head == %@ AND tail == %@", head, tail)
        fetchRequest.fetchLimit = 1
        return Future<Void, Error> { promise in
            self.context.perform {
                do {
                    let results = try self.context.fetch(fetchRequest)
                    if let amiibo = results.first {
                        self.context.delete(amiibo)
                        try self.context.save()
                    }
                    promise(.success(()))
                } catch {
                    self.context.rollback()
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func insertAll(data: AmiiboEntity) -> AnyPublisher<Void, Error> {
        return Future<Void, Error> { promise in
            self.context.perform {
                do {
                    self.context.insert(data)
                    try self.context.save()
                    promise(.success(()))
                } catch {
                    self.context.rollback()
                    promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
}
