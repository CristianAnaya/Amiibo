//
//  MockNetworkVerify.swift
//  InfrastructureTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import Foundation
import Combine
import Alamofire
@testable import Infrastructure

class MockNetworkVerify: NetworkVerify {
    var isConnected = true

    override func hasInternetConnection() -> AnyPublisher<Bool, Error> {
        return Just(isConnected)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
    }
    
}
