//
//  DeleteAmiiboFavoriteUseCaseTests.swift
//  DomainTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import XCTest
import Combine
@testable import Domain

final class DeleteAmiiboFavoriteUseCaseTests: XCTestCase {

    private var fakeRepository: FakeAmiiboRepository!
    private var useCase: DeleteAmiiboFavoriteUseCase!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        fakeRepository = FakeAmiiboRepository()
        useCase = DeleteAmiiboFavoriteUseCase(amiiboRepository: fakeRepository)
    }
        
    override func tearDown() {
        fakeRepository = nil
        useCase = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func test_DeleteAmiiboFavoriteWhenIsInvoke_success() throws {
        // Arrange
        let amiibo = try AmiiboDataBuilder().build()
        fakeRepository.deleteFavoriteReturnValue = Just(())
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        // Act
        let expectation = XCTestExpectation(description: "Save Amiibo Favorite")
        try useCase.invoke(head: amiibo.head, tail: amiibo.tail)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected error: \(error)")
                }
                expectation.fulfill()
            }, receiveValue: {
                // Assert
                XCTAssertTrue(self.fakeRepository.deleteFavoriteCalled)
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }

    func test_DeleteAmiiboFavoriteWhenIsInvoke_failure() throws {
        // Arrange
        let amiibo = try AmiiboDataBuilder().build()
        let error = NSError(domain: "com.example.error", code: 500, userInfo: nil)
        fakeRepository.deleteFavoriteReturnValue = Result.Publisher(Result.failure(error)).eraseToAnyPublisher()
        
        // Act
        let expectation = XCTestExpectation(description: "Save Amiibo Favorite")
        try useCase.invoke(head: amiibo.head, tail: amiibo.tail)
            .sink(receiveCompletion: { completion in
                if case .failure(let receivedError) = completion {
                    // Assert
                    XCTAssertEqual(receivedError as NSError, error)
                } else {
                    XCTFail("Expected failure but received completion: \(completion)")
                }
                expectation.fulfill()
            }, receiveValue: {
                XCTFail("Expected failure but received value: \($0)")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }

}
