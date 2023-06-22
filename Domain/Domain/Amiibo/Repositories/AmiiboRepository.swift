//
//  AmiiboRepository.swift
//  Domain
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation
import Combine

public protocol AmiiboRepository {
    func getDetail(head: String, tail: String) -> AnyPublisher<Amiibo?, Error>
    func getAmiiboList() -> AnyPublisher<[Amiibo], Error>
    func getFavoriteAmiiboList() throws -> AnyPublisher<[Amiibo], Error>
    func saveFavorite(amiibo: Amiibo) -> AnyPublisher<Void, Error>
    func deleteFavorite(head: String, tail: String) throws -> AnyPublisher<Void, Error>
}
