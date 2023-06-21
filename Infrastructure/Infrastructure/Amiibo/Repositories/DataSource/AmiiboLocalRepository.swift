//
//  AmiiboLocalRepository.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation
import Combine
import CoreData
import Domain

public protocol AmiiboLocalRepository {
    func getFavoriteAmiiboList() throws -> AnyPublisher<[Amiibo], Error>
    func insertMovies(data: Amiibo) throws
    func deleteFavoriteAmiibo(id: String)
}
