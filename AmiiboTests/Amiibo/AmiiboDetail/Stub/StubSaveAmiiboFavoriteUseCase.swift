//
//  StubSaveAmiiboFavoriteUseCase.swift
//  AmiiboTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 23/06/23.
//

import Foundation
import Combine
@testable import Domain
import XCTest

class StubSaveAmiiboFavoriteUseCase: SaveAmiiboFavoriteUseCase {
    
    var invokeExpectation = XCTestExpectation(description: "Invoke expectation")
    var invokedAmiibo: Amiibo?
    var stubbedInvokeResult: Result<Void, Error> = .success(())
    
    override func invoke(amiibo: Amiibo) -> AnyPublisher<Void, Error> {
        invokedAmiibo = amiibo
        
        let publisher = Result.Publisher(stubbedInvokeResult)
            .eraseToAnyPublisher()
        
        invokeExpectation.fulfill()
        
        return publisher
    }
    
}
