//
//  StubGetAmiiboListUseCase.swift
//  AmiiboTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 23/06/23.
//

import Foundation
import Combine
@testable import Domain
import XCTest

class StubGetAmiiboListUseCase: GetAmiiboListUseCase {
    var stubbedInvokeResult: Result<[Amiibo], Error>!
    var invokeExpectation: XCTestExpectation? = XCTestExpectation(description: "Invoke Expectation")

    override func invoke() -> AnyPublisher<[Amiibo], Error> {
        invokeExpectation?.fulfill()
        return Result.Publisher(stubbedInvokeResult)
            .eraseToAnyPublisher()
    }
    
}

