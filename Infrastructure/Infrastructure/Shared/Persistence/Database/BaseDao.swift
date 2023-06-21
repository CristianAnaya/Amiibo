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
    func fetchOne(id: Int) -> AnyPublisher<T?, Error>
    func count() -> AnyPublisher<Int, Error>
    func count(predicate: NSPredicate) -> AnyPublisher<Int, Error>
    func delete(_ object: T) throws
    func insertAll(data: [T]) throws
}
