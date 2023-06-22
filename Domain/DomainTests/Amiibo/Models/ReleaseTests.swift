//
//  ReleaseTests.swift
//  DomainTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import XCTest
@testable import Domain

final class ReleaseTests: XCTestCase {

    func test_createReleaseWithValidData_createInstanceOfRelease() {
        // Arrange - Act
        let release = ReleaseDataBuilder().build()

        // Assert
        XCTAssertEqual(release.formattedAU, "29-nov.-2014")
        XCTAssertEqual(release.formattedEU, "28-nov.-2014")
        XCTAssertEqual(release.formattedJP, "06-dic.-2014")
        XCTAssertEqual(release.formattedNA, "21-nov.-2014")
    }
    
    func test_createRelease_formattedAUWithNilValue() {
        // Arrange - Act
        let releaseBuilder = ReleaseDataBuilder()
        let release = Release(au: nil, eu: releaseBuilder.eu, jp: releaseBuilder.jp, na: releaseBuilder.na)

        // Assert
        XCTAssertEqual(release.formattedAU, "No Disponible")
    }

    func test_createRelease_formattedEUWithNilValue() {
        // Arrange - Act
        let releaseBuilder = ReleaseDataBuilder()
        let release = Release(au: releaseBuilder.au, eu: nil, jp: releaseBuilder.jp, na: releaseBuilder.na)
        
        // Assert
        XCTAssertEqual(release.formattedEU, "No Disponible")
    }
    
    func test_createRelease_formattedJPWithNilValue() {
        // Arrange - Act
        let releaseBuilder = ReleaseDataBuilder()
        let release = Release(au: releaseBuilder.au, eu: releaseBuilder.eu, jp: nil, na: releaseBuilder.na)

        // Assert
        XCTAssertEqual(release.formattedJP, "No Disponible")
    }
    
    func test_createRelease_formattedNAWithNilValue() {
        // Arrange - Act
        let releaseBuilder = ReleaseDataBuilder()
        let release = Release(au: releaseBuilder.au, eu: releaseBuilder.eu, jp: releaseBuilder.jp, na: nil)

        // Assert
        XCTAssertEqual(release.formattedNA, "No Disponible")
    }
    
}
