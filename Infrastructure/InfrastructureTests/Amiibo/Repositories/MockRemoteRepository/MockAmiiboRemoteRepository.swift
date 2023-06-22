//
//  MockAmiiboRemoteRepository.swift
//  InfrastructureTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import Foundation
import Combine
@testable import Infrastructure
@testable import Domain

class MockAmiiboRemoteRepository: AmiiboRemoteRepository {
  
    var getDetailReturnValue: AnyPublisher<Amiibo?, Error>!
    var getAmiiboListReturnValue: AnyPublisher<[Amiibo], Error>!
    
    func getAmiiboList() throws -> AnyPublisher<[Amiibo], Error> {
        return getAmiiboListReturnValue
    }
    
    func getAmiiboDetail(head: String, tail: String) throws -> AnyPublisher<Amiibo?, Error> {
        return getDetailReturnValue
    }
}
