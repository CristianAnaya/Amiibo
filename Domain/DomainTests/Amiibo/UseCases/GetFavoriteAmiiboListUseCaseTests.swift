//
//  GetFavoriteAmiiboListUseCaseTests.swift
//  DomainTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import XCTest
import Combine
@testable import Domain

final class GetFavoriteAmiiboListUseCaseTests: XCTestCase {

    private var fakeRepository: FakeAmiiboRepository!
    private var useCase: GetFavoriteAmiiboListUseCase!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        fakeRepository = FakeAmiiboRepository()
        useCase = GetFavoriteAmiiboListUseCase(amiiboRepository: fakeRepository)
    }
        
    override func tearDown() {
        fakeRepository = nil
        useCase = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func test_getFavoriteAmiiboListWhenIsInvoke_amiiboListResponse() throws {
        // Arrange
        let expectedAmiiboList: [Amiibo] = try AmiiboDataBuilder().buildAmiiboList(amount: 3)
        fakeRepository.getFavoriteAmiiboListReturnValue = Just(expectedAmiiboList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
            
        // Act
        let expectation = XCTestExpectation(description: "Get Favorite Amiibo List")
        var receivedAmiibo: [Amiibo] = []

        try useCase.invoke()
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
    
    func test_getFavoriteAmiiboListWhenIsInvoke_emptyAmiiboList() throws {
        // Arrange
        let expectedAmiiboList: [Amiibo] = []

        fakeRepository.getFavoriteAmiiboListReturnValue = Just(expectedAmiiboList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        // Act
        let expectation = XCTestExpectation(description: "Get Favorite Amiibo List")
        try useCase.invoke()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    // Assert
                    XCTAssertEqual(error as? AmiiboException, AmiiboException.emptyAmiiboFavoriteList)
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
