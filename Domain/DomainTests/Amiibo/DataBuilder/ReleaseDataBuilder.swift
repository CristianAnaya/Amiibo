//
//  ReleaseDataBuilder.swift
//  DomainTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import Foundation
@testable import Domain

class ReleaseDataBuilder {
    let au: String? = "2014-11-29"
    let eu: String? = "2014-11-28"
    let jp: String? = "2014-12-06"
    let na: String? = "2014-11-21"
    
    func build() -> Release {
        Release(
            au: au,
            eu: eu,
            jp: jp,
            na: na
        )
    }
}
