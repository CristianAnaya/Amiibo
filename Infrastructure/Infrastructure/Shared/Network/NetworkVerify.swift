//
//  NetworkVerify.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Alamofire
import Combine

class NetworkVerify {
    private let reachabilityManager = NetworkReachabilityManager()

    func hasInternetConnection() -> AnyPublisher<Bool, Error> {
        let isConnected = reachabilityManager?.isReachable ?? false
        return Just(isConnected)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
