//
//  GetAmiiboListUseCaseTests.swift
//  DomainTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import XCTest
import Combine
@testable import Domain

final class GetAmiiboListUseCaseTests: XCTestCase {

    private var fakeRepository: FakeAmiiboRepository!
    private var useCase: GetAmiiboListUseCase!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        fakeRepository = FakeAmiiboRepository()
        useCase = GetAmiiboListUseCase(amiiboRepository: fakeRepository)
    }
        
    override func tearDown() {
        fakeRepository = nil
        useCase = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func test_getAmiiboListWhenIsInvoke_amiiboListResponse() throws {
        // Arrange
        let expectedAmiiboList: [Amiibo] = try AmiiboDataBuilder().buildAmiiboList(amount: 2)
        fakeRepository.getAmiiboListReturnValue = Just(expectedAmiiboList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
            
        // Act
        let expectation = XCTestExpectation(description: "Get Amiibo List")
        var receivedAmiibo: [Amiibo] = []

        useCase.invoke()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected error: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: { amiiboList in
                receivedAmiibo = amiiboList
            })
            .store(in: &cancellables)
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedAmiibo, expectedAmiiboList)
    }
    
    func test_getAmiiboListWhenIsInvoke_emptyAmiiboList() {
        // Arrange
        let expectedAmiiboList: [Amiibo] = []

        fakeRepository.getAmiiboListReturnValue = Just(expectedAmiiboList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        // Act
        let expectation = XCTestExpectation(description: "Get Amiibo List")
        useCase.invoke()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    // Assert
                    XCTAssertEqual(error as? AmiiboException, AmiiboException.emptyAmiiboList)
                } else {
                    XCTFail("Expected error")
                }
                expectation.fulfill()
            }, receiveValue: { _ in
                XCTFail("Expected error")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
}
