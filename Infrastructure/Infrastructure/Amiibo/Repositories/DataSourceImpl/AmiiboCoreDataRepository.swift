//
//  AmiiboCoreDataRepository.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation
import Domain
import Combine

class AmiiboCoreDataRepository: AmiiboLocalRepository {
    
    private let amiiboDao: AmiiboDao
    
    public init(dao: AmiiboDao) {
        self.amiiboDao = dao
    }
    
    func getFavoriteAmiiboList() throws -> AnyPublisher<[Amiibo], Error> {
        return amiiboDao.fetchAll()
            .tryMap { amiiboEntities -> [Amiibo] in
                return try amiiboEntities.map {
                    do {
                        return try AmiiboMapper.fromEntityToDomain(amiiboEntity: $0)
                    } catch {
                        throw error
                    }
                }
            }
            .eraseToAnyPublisher()
    }
    
    func insertAmiibo(data: Amiibo) -> AnyPublisher<Void, Error> {
        let amiiboEntity = AmiiboMapper.fromDomainToEntity(amiibo: data, context: amiiboDao.context)
        return amiiboDao.insertAll(data: amiiboEntity)
    }
    
    func deleteFavoriteAmiibo(head: String, tail: String) -> AnyPublisher<Void, Error> {
        return amiiboDao.delete(head: head, tail: tail)
    }

}
