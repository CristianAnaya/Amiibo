//
//  AmiiboFavoritesViewModelTests.swift
//  AmiiboTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 23/06/23.
//

import XCTest
import Combine
@testable import Amiibo
@testable import Domain

final class AmiiboFavoritesViewModelTests: XCTestCase {

    var viewModel: FavoriteAmiiboViewModel!
    var stubFavoriteGetAmiiboListUseCase: StubGetFavoriteAmiiboListUseCase!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        stubFavoriteGetAmiiboListUseCase = StubGetFavoriteAmiiboListUseCase(
            amiiboRepository: DependencyInjectionContainer.shared.resolve(AmiiboRepository.self)!
        )
        viewModel = FavoriteAmiiboViewModel(
            getFavoriteAmiiboListUseCase: stubFavoriteGetAmiiboListUseCase
        )
        cancellables = Set<AnyCancellable>()
    }

    override func tearDown() {
        viewModel = nil
        stubFavoriteGetAmiiboListUseCase = nil
        cancellables = nil
        super.tearDown()
    }

    func test_fetchFavoritesAmiibo_success() throws {
        // Arrange
        let amiiboList = try AmiiboDataBuilder().buildAmiiboList(amount: 3)
        stubFavoriteGetAmiiboListUseCase.stubbedInvokeResult = .success(amiiboList)

        // Act
        viewModel.fetchFavoritesAmiibo()

        // Assert
        XCTAssertEqual(viewModel.isLoading, false)

        wait(for: [stubFavoriteGetAmiiboListUseCase.invokeExpectation!], timeout: 1.0)

        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.favoriteAmiiboList, amiiboList)
        XCTAssertNil(viewModel.errorMessage)
    }

    func test_fetchFavoritesAmiibo_failure() {
        // Arrange
        let expectedError = NSError(domain: "TestError", code: 0, userInfo: nil)
        stubFavoriteGetAmiiboListUseCase.stubbedInvokeResult = .failure(expectedError)

        // Act
        viewModel.fetchFavoritesAmiibo()

        // Assert
        XCTAssertEqual(viewModel.isLoading, false)

        wait(for: [stubFavoriteGetAmiiboListUseCase.invokeExpectation!], timeout: 1.0)

        XCTAssertEqual(viewModel.isLoading, false)
        XCTAssertEqual(viewModel.errorMessage, expectedError.localizedDescription)
    }

}
