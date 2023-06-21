//
//  AmiiboRepository.swift
//  Domain
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation
import Combine

public protocol AmiiboRepository {
    func getDetail(id: Int) -> AnyPublisher<Amiibo?, Error>
    func getAmiiboList() -> AnyPublisher<[Amiibo], Error>
    func getFavoriteAmiiboList() -> AnyPublisher<[Amiibo], Error>
}
