//
//  AmiiboProxy.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation
import Domain
import Combine

struct AmiiboProxy: AmiiboRepository {
    private let amiiboLocalRepository: AmiiboLocalRepository
    private let amiiboRemoteRepository: AmiiboRemoteRepository
    private let networkVerify: NetworkVerify
    
    init(
        amiiboLocalRepository: AmiiboLocalRepository,
        amiiboRemoteRepository: AmiiboRemoteRepository,
        networkVerify: NetworkVerify
    ) {
        self.amiiboLocalRepository = amiiboLocalRepository
        self.amiiboRemoteRepository = amiiboRemoteRepository
        self.networkVerify = networkVerify
    }
    
    func getDetail(head: String, tail: String) -> AnyPublisher<Amiibo?, Error> {
        return networkVerify.hasInternetConnection()
            .flatMap { isConnected -> AnyPublisher<Amiibo?, Error> in
                guard isConnected else {
                    return Fail(error: NotConnectedToNetworkException()).eraseToAnyPublisher()
                }
                return try! amiiboRemoteRepository.getAmiiboDetail(head: head, tail: tail)
            }
            .eraseToAnyPublisher()
    }
    
    func getAmiiboList() -> AnyPublisher<[Amiibo], Error> {
        return networkVerify.hasInternetConnection()
            .flatMap { isConnected -> AnyPublisher<[Amiibo], Error> in
                guard isConnected else {
                    return Fail(error: NotConnectedToNetworkException()).eraseToAnyPublisher()
                }
                return try! amiiboRemoteRepository.getAmiiboList()
            }
            .eraseToAnyPublisher()
    }
    
    func getFavoriteAmiiboList() throws -> AnyPublisher<[Amiibo], Error> {
        return try amiiboLocalRepository.getFavoriteAmiiboList()
    }
    
    func saveFavorite(amiibo: Amiibo) -> AnyPublisher<Void, Error> {
        return amiiboLocalRepository.insertAmiibo(data: amiibo)
    }
    
    func deleteFavorite(head: String, tail: String) -> AnyPublisher<Void, Error> {
        return amiiboLocalRepository.deleteFavoriteAmiibo(head: head, tail: tail)
    }

}
