//
//  NotConnectedToNetworkException.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation

public let notConnectedToNetworkMessage: String = "notConnectedToNetwork"

public struct NotConnectedToNetworkException: LocalizedError {
    public var errorDescription: String?
    public init(message: String = notConnectedToNetworkMessage.localized(tableName: "")) {
        self.errorDescription = message
    }
}
