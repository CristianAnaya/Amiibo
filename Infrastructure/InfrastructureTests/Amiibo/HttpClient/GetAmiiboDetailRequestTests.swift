//
//  GetAmiiboDetailRequestTests.swift
//  InfrastructureTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import XCTest
import Combine
import Alamofire
@testable import Infrastructure

final class GetAmiiboDetailRequestTests: XCTestCase {
    
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

    func test_requestFromApi_getAmiiboDetailRequest() throws {
        // Arrange
        let request = MockGetAmiiboDetailRequest(object: nil, path: "0x0000010000190002")
                
        // Act
        let expectation = XCTestExpectation(description: "Fetch Amiibo Detail")
        sut.requestGeneric(request: request, entity: AmiiboDetailResponse.self, queue: .global())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Unexpected error: \(error.localizedDescription)")
                case .finished:
                    expectation.fulfill()
                }
            }, receiveValue: { response in
                // Assert
                XCTAssertNotNil(response)
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 15.0)
    }

}
