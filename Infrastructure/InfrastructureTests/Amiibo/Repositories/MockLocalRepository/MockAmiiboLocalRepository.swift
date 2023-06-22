//
//  MockAmiiboLocalRepository.swift
//  InfrastructureTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import Foundation
import Combine
@testable import Infrastructure
@testable import Domain

class MockAmiiboLocalRepository: AmiiboLocalRepository {
    var saveFavoriteCalled = false
    var deleteFavoriteCalled = false
    var getFavoriteAmiiboListReturnValue: AnyPublisher<[Amiibo], Error>!
    var saveFavoriteReturnValue: AnyPublisher<Void, Error>!
    var deleteFavoriteReturnValue: AnyPublisher<Void, Error>!
    
    func getFavoriteAmiiboList() throws -> AnyPublisher<[Amiibo], Error> {
        return getFavoriteAmiiboListReturnValue
    }
    
    func insertAmiibo(data: Amiibo) -> AnyPublisher<Void, Error> {
        saveFavoriteCalled = true
        return saveFavoriteReturnValue
    }
    
    func deleteFavoriteAmiibo(head: String, tail: String) -> AnyPublisher<Void, Error> {
        deleteFavoriteCalled = true
        return deleteFavoriteReturnValue
    }
    
}
