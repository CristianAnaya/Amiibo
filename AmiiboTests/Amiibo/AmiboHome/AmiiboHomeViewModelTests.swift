//
//  AmiiboHomeViewModelTests.swift
//  AmiiboTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 23/06/23.
//

import XCTest
import Combine
@testable import Amiibo
@testable import Domain

class AmiiboHomeViewModelTests: XCTestCase {

    var viewModel: AmiiboHomeViewModel!
    var stubGetAmiiboListUseCase: StubGetAmiiboListUseCase!
    var stubFilterAmiiboByTypeUseCase: StubFilterAmiiboByTypeUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        stubGetAmiiboListUseCase = StubGetAmiiboListUseCase(
            amiiboRepository: DependencyInjectionContainer.shared.resolve(AmiiboRepository.self)!
        )
        stubFilterAmiiboByTypeUseCase = StubFilterAmiiboByTypeUseCase(
            amiiboRepository: DependencyInjectionContainer.shared.resolve(AmiiboRepository.self)!
        )
        viewModel = AmiiboHomeViewModel(
            getAmiiboListUseCase: stubGetAmiiboListUseCase,
            filterAmiiboByTypeUseCase: stubFilterAmiiboByTypeUseCase
        )
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        viewModel = nil
        stubGetAmiiboListUseCase = nil
        stubFilterAmiiboByTypeUseCase = nil
        cancellables = nil
        super.tearDown()
    }

    func test_fetchAmiiboList_success() throws {
        // Arrange
        let amiiboList = try AmiiboDataBuilder().buildAmiiboList(amount: 3)
        stubGetAmiiboListUseCase.stubbedInvokeResult = .success(amiiboList)

        // Act
        viewModel.fetchAmiiboList()

        // Assert
        XCTAssertEqual(viewModel.isLoading, false)

        wait(for: [stubGetAmiiboListUseCase.invokeExpectation!], timeout: 1.0)

        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.amiiboList, amiiboList)
        XCTAssertNil(viewModel.errorMessage)
    }

    func test_fetchAmiiboList_failure() {
        // Arrange
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        stubGetAmiiboListUseCase.stubbedInvokeResult = .failure(expectedError)

        // Act
        viewModel.fetchAmiiboList()

        // Assert
        XCTAssertEqual(viewModel.isLoading, false)

        wait(for: [stubGetAmiiboListUseCase.invokeExpectation!], timeout: 1.0)

        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.errorMessage, expectedError.localizedDescription)
    }
    
    func test_filterAmiiboByType_success() throws {
        // Arrange
        let amiiboList = try AmiiboDataBuilder().buildAmiiboList(amount: 3)
        stubFilterAmiiboByTypeUseCase.stubbedInvokeResult = .success(amiiboList)

        // Act
        viewModel.filterAmiiboByType(type: "Type")

        // Assert
        XCTAssertEqual(viewModel.isLoading, false)

        wait(for: [stubFilterAmiiboByTypeUseCase.invokeExpectation!], timeout: 1.0)

        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.amiiboList, amiiboList)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func test_filterAmiiboByType_failure() {
        // Arrange
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        stubFilterAmiiboByTypeUseCase.stubbedInvokeResult = .failure(expectedError)

        // Act
        viewModel.filterAmiiboByType(type: "Type")

        // Assert
        XCTAssertEqual(viewModel.isLoading, false)

        wait(for: [stubFilterAmiiboByTypeUseCase.invokeExpectation!], timeout: 1.0)

        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.errorMessage, expectedError.localizedDescription)
    }

}
