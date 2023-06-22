//
//  GetAmiiboListRequestTests.swift
//  InfrastructureTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import XCTest
import Combine
import Alamofire
@testable import Infrastructure

final class GetAmiiboListRequestTests: XCTestCase {
    private var sut: HttpClient!
    private var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = HttpClient()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func test_requestFromApi_getAmiiboListRequest() throws {
        // Arrange
        let request = MockGetAmiiboListRequest(object: nil, path: nil)
                
        // Act
        let expectation = XCTestExpectation(description: "Fetch Amiibo list")
        sut.requestGeneric(request: request, entity: AmiiboListResponse.self, queue: .global())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Unexpected error: \(error.localizedDescription)")
                case .finished:
                    expectation.fulfill()
                }
            }, receiveValue: { response in
                // Assert
                XCTAssertNotNil(response.amiibo)
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 15.0)
    }
    
}
