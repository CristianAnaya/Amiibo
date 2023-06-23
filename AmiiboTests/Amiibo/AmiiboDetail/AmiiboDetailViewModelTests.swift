//
//  AmiiboDetailViewModelTests.swift
//  AmiiboTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 23/06/23.
//

import XCTest
import Combine
@testable import Amiibo
@testable import Domain

final class AmiiboDetailViewModelTests: XCTestCase {

    var viewModel: AmiiboDetailViewModel!
    var stubGetAmiiboDetailUseCase: StubGetAmiiboDetailUseCase!
    var stubSaveAmiiboFavoriteUseCase: StubSaveAmiiboFavoriteUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        stubGetAmiiboDetailUseCase = StubGetAmiiboDetailUseCase(
            amiiboRepository: DependencyInjectionContainer.shared.resolve(AmiiboRepository.self)!
        )
        stubSaveAmiiboFavoriteUseCase = StubSaveAmiiboFavoriteUseCase(
            amiiboRepository: DependencyInjectionContainer.shared.resolve(AmiiboRepository.self)!
        )
        viewModel = AmiiboDetailViewModel(
            getAmiiboDetailUseCase: stubGetAmiiboDetailUseCase,
            saveAmiiboFavoriteUseCase: stubSaveAmiiboFavoriteUseCase,
            head: "Head",
            tail: "Tail"
        )
    }

    override func tearDown() {
        viewModel = nil
        stubGetAmiiboDetailUseCase = nil
        stubSaveAmiiboFavoriteUseCase = nil
        cancellables = nil
        super.tearDown()
    }

    func test_fetchAmiibo_success() throws {
        // Arrange
        let amiibo = try AmiiboDataBuilder().build()
        stubGetAmiiboDetailUseCase.stubbedInvokeResult = .success(amiibo)
        
        // Act
        viewModel.fetchAmiibo()
        
        // Assert
        XCTAssertEqual(viewModel.isLoading, false)

        wait(for: [stubGetAmiiboDetailUseCase.invokeExpectation!], timeout: 1.0)
        
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.amiibo, amiibo)
        XCTAssertNil(viewModel.message)
    }
    
    func test_fetchAmiibo_failure() throws {
        // Arrange
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        stubGetAmiiboDetailUseCase.stubbedInvokeResult = .failure(expectedError)
        
        // Act
        viewModel.fetchAmiibo()
        
        // Assert
        XCTAssertEqual(viewModel.isLoading, false)

        
        wait(for: [stubGetAmiiboDetailUseCase.invokeExpectation!], timeout: 1.0)
        
        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertNil(viewModel.amiibo)
        XCTAssertEqual(viewModel.message, expectedError.localizedDescription)
    }

    func test_saveAmiibo_success() throws {
        // Arrange
        let amiibo = try AmiiboDataBuilder().build()
        viewModel.amiibo = amiibo
        stubSaveAmiiboFavoriteUseCase.stubbedInvokeResult = .success(())
        
        // Act
        viewModel.saveAmiibo()
        
        // Assert
        wait(for: [stubSaveAmiiboFavoriteUseCase.invokeExpectation], timeout: 1.0)
        
        XCTAssertEqual(viewModel.message, "Se guardó correctamente")
    }

    func test_saveAmiibo_failed() throws {
        // Arrange
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        let amiibo = try AmiiboDataBuilder().build()
        viewModel.amiibo = amiibo
        stubSaveAmiiboFavoriteUseCase.stubbedInvokeResult = .failure(expectedError)
        
        // Act
        viewModel.saveAmiibo()
        
        // Assert
        
        wait(for: [stubSaveAmiiboFavoriteUseCase.invokeExpectation], timeout: 1.0)

        XCTAssertNotNil(viewModel.message)
    }

}
