//
//  Release.swift
//  Domain
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation

public struct Release {
    public let au: String?
    public let eu: String?
    public let jp: String?
    public let na: String?
    
    public init(au: String?, eu: String?, jp: String?, na: String?) {
        self.au = au
        self.eu = eu
        self.jp = jp
        self.na = na
    }
}
