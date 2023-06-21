//
//  AmiiboRemoteRepository.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation
import Combine
import Domain

public protocol AmiiboRemoteRepository {
    func getAmiiboList() throws -> AnyPublisher<[Amiibo], Error>
    func getAmiiboDetail() throws -> AnyPublisher<Amiibo?, Error>
}
