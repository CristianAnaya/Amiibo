//
//  AmiiboDaoTests.swift
//  InfrastructureTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import XCTest
@testable import Infrastructure
import Combine

final class AmiiboDaoTests: XCTestCase {

    private var amiiboDatabase: AmiiboDatabase!
    private var sut: AmiiboDao!
    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        amiiboDatabase = AmiiboDatabase(modelName: "Amiibo", isTestMode: true)
        sut = AmiiboDao(context: amiiboDatabase.managedContext)
    }
        
    override func tearDown() {
        super.tearDown()
        amiiboDatabase = nil
        cancellables.removeAll()
        sut = nil
    }
    
    func test_insertAll_saveFavoriteAmiibo() {
        // Arrange
        let amiiboEntity = AmiiboDataBuilder().buildEntity(context: amiiboDatabase.managedContext)
        
        // Act
        sut.insertAll(data: amiiboEntity)
            .sink(receiveCompletion: { _ in }, receiveValue: {})
            .store(in: &cancellables)
        let expectation = XCTestExpectation(description: "Fetch all amiibo entities")

        sut.fetchAll()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTFail("Failed to fetch amiibo entities: \(error)")
                }
            }, receiveValue: { results in
                // Assert
                XCTAssertEqual(results.count, 1)
                let fetchedAmiiboEntity = results.first
                XCTAssertNotNil(fetchedAmiiboEntity)
                XCTAssertNotNil(fetchedAmiiboEntity?.amiiboRelease)
                expectation.fulfill()
            })
            .store(in: &cancellables)
            
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_fetchAll_getFavoriteAmiiboList() {
        // Arrange
        let amiiboEntityFirst = AmiiboDataBuilder().buildEntity(context: amiiboDatabase.managedContext)
        let releaseEntity = ReleaseDataBuilder().buildEntity(context: amiiboDatabase.managedContext)
        releaseEntity.au = "19-nov.-2014"
        releaseEntity.eu = "18-nov.-2014"
        releaseEntity.jp = "16-dic.-2014"
        releaseEntity.na = "11-nov.-2014"
        let amiiboEntitySecond = AmiiboDataBuilder().buildEntity(context: amiiboDatabase.managedContext)
        amiiboEntitySecond.amiiboRelease = releaseEntity
        
        sut.insertAll(data: amiiboEntityFirst)
            .sink(receiveCompletion: { _ in }, receiveValue: {})
            .store(in: &cancellables)
        sut.insertAll(data: amiiboEntitySecond)
            .sink(receiveCompletion: { _ in }, receiveValue: {})
            .store(in: &cancellables)
        
        // Act
        let expectation = XCTestExpectation(description: "Fetch all amiibo entities")
        sut.fetchAll()
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTFail("Failed to fetch amiibo entities: \(error)")
                }
            }, receiveValue: { results in
                // Assert
                XCTAssertEqual(results.count, 2)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }

    func test_delete_deleteFavoriteAmiibo() {
        // Arrange
        let amiiboEntity = AmiiboDataBuilder().buildEntity(context: amiiboDatabase.managedContext)
        
        // Act
        sut.insertAll(data: amiiboEntity)
            .sink(receiveCompletion: { _ in }, receiveValue: {})
            .store(in: &cancellables)
        let expectation = XCTestExpectation(description: "Delete amiibo entity")

        sut.delete(head: amiiboEntity.head, tail: amiiboEntity.tail)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTFail("Failed to delete amiibo entity: \(error)")
                }
            }, receiveValue: {
                // Assert
                expectation.fulfill()
            })
            .store(in: &cancellables)
                
        wait(for: [expectation], timeout: 1.0)
    }

    
}
