//
//  AmiiboDataBuilder.swift
//  InfrastructureTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import Foundation
import CoreData
@testable import Domain
@testable import Infrastructure


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
    
    func buildEntity(context: NSManagedObjectContext) -> AmiiboEntity {
        let amiiboEntity = AmiiboEntity(context: context)
        amiiboEntity.head = head
        amiiboEntity.tail = tail
        amiiboEntity.name = name
        amiiboEntity.amiiboSeries = amiiboSeries
        amiiboEntity.type = type
        amiiboEntity.image = image
        amiiboEntity.character = character
        amiiboEntity.amiiboRelease = ReleaseDataBuilder().buildEntity(context: context)

        return amiiboEntity
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
