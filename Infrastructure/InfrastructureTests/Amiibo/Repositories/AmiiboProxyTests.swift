//
//  AmiiboProxyTests.swift
//  InfrastructureTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import XCTest
import Combine
import Alamofire
@testable import Infrastructure
@testable import Domain

final class AmiiboProxyTests: XCTestCase {
    var amiiboLocalRepository: MockAmiiboLocalRepository!
    var amiiboRemoteRepository: MockAmiiboRemoteRepository!
    var networkVerify: MockNetworkVerify!
    var amiiboProxy: AmiiboProxy!

    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        
        amiiboLocalRepository = MockAmiiboLocalRepository()
        amiiboRemoteRepository = MockAmiiboRemoteRepository()
        networkVerify = MockNetworkVerify()
        
        amiiboProxy = AmiiboProxy(
            amiiboLocalRepository: amiiboLocalRepository,
            amiiboRemoteRepository: amiiboRemoteRepository,
            networkVerify: networkVerify
        )
    }
    
    override func tearDown() {
        amiiboLocalRepository = nil
        amiiboRemoteRepository = nil
        networkVerify = nil
        amiiboProxy = nil
        
        cancellables.removeAll()
        
        super.tearDown()
    }
    
    func testGetDetail_withInternetConnection_returnAmiiboDetail() throws {
        // Arrange
        let amiibo = try AmiiboDataBuilder().build()
        var receivedAmiibo: Amiibo? = nil

        let expectedResult = Just<Amiibo?>(amiibo)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "Get amiibo detail")

        amiiboRemoteRepository.getDetailReturnValue = expectedResult
        networkVerify.isConnected = true

        // Act
        amiiboProxy.getDetail(head: "00000100", tail: "00190002")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected error: \(error)")
                }
            }, receiveValue: { result in
                receivedAmiibo = result
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedAmiibo, amiibo)

    }
    
    func testGetDetail_withoutInternetConnection_returnNetworkException() throws {
        // Arrange
        let amiibo = try AmiiboDataBuilder().build()

        let expectedResult = Just<Amiibo?>(amiibo)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "Get amiibo detail")

        amiiboRemoteRepository.getDetailReturnValue = expectedResult
        networkVerify.isConnected = false

        // Act
        amiiboProxy.getDetail(head: "00000100", tail: "00190002")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertTrue(error is NotConnectedToNetworkException)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure with NotConnectedToNetworkException")
            })
            .store(in: &cancellables)
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }

    func testGetAmiiboList_withInternetConnection_returnAmiiboList() throws {
        // Arrange
        let amiiboList = try AmiiboDataBuilder().buildAmiiboList(amount: 2)
        var receivedAmiibo: [Amiibo] = []

        let expectedResult = Just<[Amiibo]>(amiiboList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "Get amiibo list")

        amiiboRemoteRepository.getAmiiboListReturnValue = expectedResult
        networkVerify.isConnected = true

        // Act
        amiiboProxy.getAmiiboList()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected error: \(error)")
                }
            }, receiveValue: { result in
                receivedAmiibo = result
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedAmiibo.count, amiiboList.count)

    }

    func testGetAmiiboList_withoutInternetConnection_returnAmiiboList() throws {
        // Arrange
        let amiiboList = try AmiiboDataBuilder().buildAmiiboList(amount: 2)
        let expectedResult = Just<[Amiibo]>(amiiboList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "Get amiibo list")

        amiiboRemoteRepository.getAmiiboListReturnValue = expectedResult
        networkVerify.isConnected = false

        // Act
        amiiboProxy.getAmiiboList()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertTrue(error is NotConnectedToNetworkException)
                    expectation.fulfill()
                }
            }, receiveValue: { result in
                XCTFail("Expected failure with NotConnectedToNetworkException")
            })
            .store(in: &cancellables)
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
    }
    
    func test_getFavoriteAmiiboList_returnFavoriteAmiiboList() throws {
        // Arrange
        let amiiboList = try AmiiboDataBuilder().buildAmiiboList(amount: 2)
        var receivedAmiibo: [Amiibo] = []

        let expectedResult = Just<[Amiibo]>(amiiboList)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        
        let expectation = XCTestExpectation(description: "Get amiibo list")

        amiiboLocalRepository.getFavoriteAmiiboListReturnValue = expectedResult
        networkVerify.isConnected = true

        // Act
        try amiiboProxy.getFavoriteAmiiboList()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Unexpected error: \(error)")
                }
            }, receiveValue: { result in
                receivedAmiibo = result
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(receivedAmiibo.count, amiiboList.count)

    }

}
