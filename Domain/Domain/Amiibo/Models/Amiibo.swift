//
//  Amiibo.swift
//  Domain
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation

public struct Amiibo: Equatable {
    public let head: String
    public let tail: String
    public let name: String
    public let amiiboSeries: String
    public let type: String
    public let image: String
    public let character: String
    public let release: Release
    
    public init(
        head: String,
        tail: String,
        name: String,
        amiiboSeries: String,
        type: String,
        image: String,
        character: String,
        release: Release
    ) throws {
        self.head = head
        self.tail = tail
        self.name = name
        self.amiiboSeries = amiiboSeries
        self.type = type
        self.image = image
        self.character = character
        self.release = release
        try validateFields()
    }
    
    private func validateFields() throws {
        try ArgumentValidator.validateEmptyParam(value: self.head)
        try ArgumentValidator.validateEmptyParam(value: self.tail)
        try ArgumentValidator.validateEmptyParam(value: self.name)
        try ArgumentValidator.validateEmptyParam(value: self.amiiboSeries)
        try ArgumentValidator.validateEmptyParam(value: self.type)
        try ArgumentValidator.validateEmptyParam(value: self.image)
    }
    
    public static func == (lhs: Amiibo, rhs: Amiibo) -> Bool {
        return lhs.head == rhs.head &&
            lhs.tail == rhs.tail &&
            lhs.name == rhs.name &&
            lhs.amiiboSeries == rhs.amiiboSeries &&
            lhs.type == rhs.type &&
            lhs.image == rhs.image &&
            lhs.character == rhs.character &&
            lhs.release == rhs.release
    }
}
