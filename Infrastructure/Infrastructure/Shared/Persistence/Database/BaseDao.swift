//
//  BaseDao.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation
import Combine

protocol BaseDao {
    associatedtype T
    func fetchAll() -> AnyPublisher<[T], Error>
    func insertAll(data: T) -> AnyPublisher<Void, Error>
}
