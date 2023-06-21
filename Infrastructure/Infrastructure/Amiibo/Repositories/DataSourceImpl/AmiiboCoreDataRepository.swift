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
        <#code#>
    }
    
    func insertMovies(data: Amiibo) throws {
        <#code#>
    }
    
    func deleteFavoriteAmiibo(id: String) {
        <#code#>
    }

}
