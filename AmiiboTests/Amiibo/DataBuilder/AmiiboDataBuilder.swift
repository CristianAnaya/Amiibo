//
//  AmiiboDataBuilder.swift
//  AmiiboTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 23/06/23.
//

import Foundation
@testable import Domain

class AmiiboDataBuilder {
    let head: String = .randomString
    let tail: String = .randomString
    let name: String = .randomString
    let amiiboSeries: String = .randomString
    let type: String = .randomString
    let image: String = .randomString
    let character: String = .randomString
    let release = ReleaseDataBuilder().build()
    
    func build() throws -> Amiibo {
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
    }
    
    func buildAmiiboList(amount: Int) throws -> [Amiibo] {
        var amiiboList = [Amiibo]()

        for _ in 0..<amount {
            let amiibo = try build()
            amiiboList.append(amiibo)
        }

        return amiiboList
    }
}
