//
//  AmiiboProxy.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation
import Domain
import Combine

/**
 `AmiiboProxy` acts as an intermediary between the local and remote Amiibo repositories.
  It implements the `AmiiboRepository` protocol, which defines methods for accessing and manipulating Amiibo data.
  This structure uses a `NetworkVerify` object to verify the internet connection before performing remote operations.
 */

struct AmiiboProxy: AmiiboRepository {

    private let amiiboLocalRepository: AmiiboLocalRepository
    private let amiiboRemoteRepository: AmiiboRemoteRepository
    private let networkVerify: NetworkVerify
    
    
    /**
     Initializes a new instance of `AmiiboProxy`.
         
     -Parameters:
            - amiiboLocalRepository: Amiibo local repository that implements `AmiiboLocalRepository`.
            - amiiboRemoteRepository: Amiibo remote repository that implements `AmiiboRemoteRepository`.
            - networkVerify: Object used to verify the internet connection before performing remote operations.
    */
    init(
        amiiboLocalRepository: AmiiboLocalRepository,
        amiiboRemoteRepository: AmiiboRemoteRepository,
        networkVerify: NetworkVerify
    ) {
        self.amiiboLocalRepository = amiiboLocalRepository
        self.amiiboRemoteRepository = amiiboRemoteRepository
        self.networkVerify = networkVerify
    }
    
    /**
        Gets the details of a specific Amiibo via the remote repository.
         
        -Parameters:
            - head: The "head" part of the Amiibo identifier.
            - tail: The "tail" part of the Amiibo's identifier.
         
        - Returns: A `Publisher` that issues an optional `Amiibo` item or an error.
    */
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
    
    /**
        Gets a list of Amiibos via the remote repository.
         
        - Returns: A `Publisher` that emits an array of `Amiibo` items or an error.
    */
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
    
    /**
    Filter the list of Amiibos by type via the remote repository.
         
    -Parameters:
        - type: The type of Amiibo by which you want to filter.
         
     - Returns: A `Publisher` that emits an array of `Amiibo` items or an error.
    */
    func filerAmiiboByType(type: String) throws -> AnyPublisher<[Amiibo], Error> {
        return networkVerify.hasInternetConnection()
            .flatMap { isConnected -> AnyPublisher<[Amiibo], Error> in
                guard isConnected else {
                    return Fail(error: NotConnectedToNetworkException()).eraseToAnyPublisher()
                }
                return try! amiiboRemoteRepository.filterAmiiboByType(type: type)
            }
            .eraseToAnyPublisher()
    }
    
    /**
      Gets a list of locally stored favorite Amiibos.
     
      - Returns: A `Publisher` that emits an array of `Amiibo` items or an error.
    */
    func getFavoriteAmiiboList() throws -> AnyPublisher<[Amiibo], Error> {
        return try amiiboLocalRepository.getFavoriteAmiiboList()
    }
    
    /**
      Save an Amiibo as a favorite in the local repository.
     
      -Parameters:
         - amiibo: The Amiibo to be saved as a favorite.
     
      - Returns: A `Publisher` that issues a `Void` object or an error.
      */
    func saveFavorite(amiibo: Amiibo) -> AnyPublisher<Void, Error> {
        return amiiboLocalRepository.insertAmiibo(data: amiibo)
    }
    
    /**
      Delete a favorite Amiibo from the local repository.
     
      -Parameters:
         - head: The "head" part of the Amiibo identifier.
         - tail: The "tail" part of the Amiibo's identifier.
     
      - Returns: A `Publisher` that issues a `Void` object or an error.
      */
    func deleteFavorite(head: String, tail: String) -> AnyPublisher<Void, Error> {
        return amiiboLocalRepository.deleteFavoriteAmiibo(head: head, tail: tail)
    }

}
