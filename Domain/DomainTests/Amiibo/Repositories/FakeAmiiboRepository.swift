//
//  FakeAmiiboRepository.swift
//  DomainTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import Foundation
@testable import Domain
import Combine

class FakeAmiiboRepository: AmiiboRepository {
    
    var saveFavoriteCalled = false
    var deleteFavoriteCalled = false
    
    var getDetailReturnValue: AnyPublisher<Amiibo?, Error>!
    var getAmiiboListReturnValue: AnyPublisher<[Amiibo], Error>!
    var getFavoriteAmiiboListReturnValue: AnyPublisher<[Amiibo], Error>!
    var saveFavoriteReturnValue: AnyPublisher<Void, Error>!
    var deleteFavoriteReturnValue: AnyPublisher<Void, Error>!
    
    func getDetail(head: String, tail: String) -> AnyPublisher<Amiibo?, Error> {
        return getDetailReturnValue
    }
    
    func getAmiiboList() -> AnyPublisher<[Amiibo], Error> {
        return getAmiiboListReturnValue
    }
    
    func getFavoriteAmiiboList() throws -> AnyPublisher<[Amiibo], Error> {
        return getFavoriteAmiiboListReturnValue
    }
    
    func saveFavorite(amiibo: Amiibo) -> AnyPublisher<Void, Error> {
        saveFavoriteCalled = true
        return saveFavoriteReturnValue
    }
    
    func deleteFavorite(head: String, tail: String) throws -> AnyPublisher<Void, Error> {
        deleteFavoriteCalled = true
        return deleteFavoriteReturnValue
    }
    
}

