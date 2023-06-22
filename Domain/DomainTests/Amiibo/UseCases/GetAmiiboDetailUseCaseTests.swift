//
//  GetAmiiboDetailUseCaseTests.swift
//  DomainTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import XCTest
import Combine
@testable import Domain

final class GetAmiiboDetailUseCaseTests: XCTestCase {

    private var fakeRepository: FakeAmiiboRepository!
    private var useCase: GetAmiiboDetailUseCase!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        fakeRepository = FakeAmiiboRepository()
        useCase = GetAmiiboDetailUseCase(amiiboRepository: fakeRepository)
    }
        
    override func tearDown() {
        fakeRepository = nil
        useCase = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func test_getAmiiboDetail_whenIsInvoke_successResponse() throws {
        // Arrange
        let expectedAmiibo = try AmiiboDataBuilder().build()
        fakeRepository.getDetailReturnValue = Just(expectedAmiibo)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
                
        // Act
        let expectation = XCTestExpectation(description: "Get Amiibo Detail")
        var receivedAmiibo: Amiibo? = nil
                
        useCase.invoke(head: expectedAmiibo.head, tail: expectedAmiibo.tail)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Unexpected error")
                }
                expectation.fulfill()
            }, receiveValue: { amiibo in
                receivedAmiibo = amiibo
            })
            .store(in: &cancellables)
                
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedAmiibo, expectedAmiibo)
    }
    
    func test_GetAmiiboDetail_whenIsInvoke_NotFound() {
        // Arrange
        fakeRepository.getDetailReturnValue = Just(nil)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
            
        // Act
        let expectation = XCTestExpectation(description: "Get Amiibo Detail")
        var receivedAmiibo: Amiibo? = nil
        var receivedError: Error? = nil
            
        useCase.invoke(head: "00000000", tail: "00000002")
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    receivedError = error
                } else {
                    XCTFail("Expected failure")
                }
                expectation.fulfill()
            }, receiveValue: { amiibo in
                receivedAmiibo = amiibo
            })
            .store(in: &cancellables)
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNil(receivedAmiibo)
        XCTAssertNotNil(receivedError)
        XCTAssertTrue(receivedError is AmiiboException)
        XCTAssertEqual((receivedError as? AmiiboException), AmiiboException.amiiboNotFound)
    }

}
