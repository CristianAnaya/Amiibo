//
//  AmiiboTests.swift
//  DomainTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import Foundation
import XCTest
@testable import Domain

final class AmiiboTests: XCTestCase {
    
    func test_createAmiiboWithValidData_createInstanceOfAmiibo() throws {
        // Arrange
        let head: String = "00000100"
        let tail: String = "00190002"
        let name: String = "Dr. Mario"
        let amiiboSeries: String = "Super Smash Bros."
        let type: String = "Figure"
        let image: String = "https://raw.githubusercontent.com/N3evin/AmiiboAPI/master/images/icon_00000100-00190002.png"
        let character: String = "Mario"
        let release: Release = ReleaseDataBuilder().build()
        
        // Act
        let amiibo = try Amiibo(
            head: head,
            tail: tail,
            name: name,
            amiiboSeries: amiiboSeries,
            type: type,
            image: image,
            character: character,
            release: release
        )
                    
        // Assert
        XCTAssertEqual(amiibo.head, "00000100")
        XCTAssertEqual(amiibo.tail, "00190002")
        XCTAssertEqual(amiibo.name, "Dr. Mario")
        XCTAssertEqual(amiibo.amiiboSeries, "Super Smash Bros.")
        XCTAssertEqual(amiibo.type, "Figure")
        XCTAssertEqual(amiibo.image, "https://raw.githubusercontent.com/N3evin/AmiiboAPI/master/images/icon_00000100-00190002.png")
        XCTAssertEqual(amiibo.character, "Mario")
        XCTAssertNotNil(release)

    }
    
    func test_createAmiibiWhenIsEmptyFields_throwsEmptyParamException() throws {
        // Arrange
        let head: String = ""
        let tail: String = "00190002"
        let name: String = "Dr. Mario"
        let amiiboSeries: String = "Super Smash Bros."
        let type: String = "Figure"
        let image: String = "https://raw.githubusercontent.com/N3evin/AmiiboAPI/master/images/icon_00000100-00190002.png"
        let character: String = "Mario"
        let release: Release = ReleaseDataBuilder().build()
        
        // Act
        XCTAssertThrowsError(
            try Amiibo(
                head: head,
                tail: tail,
                name: name,
                amiiboSeries: amiiboSeries,
                type: type,
                image: image,
                character: character,
                release: release
            )
        ) { error in
            // Assert
            XCTAssertEqual(error as? EmptyParamException, EmptyParamException.emptyField)
        }
        
    }

}
