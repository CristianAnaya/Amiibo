//
//  AmiiboException.swift
//  Domain
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation

public enum AmiiboException: Error, LocalizedError, Equatable {
    case amiiboListUnexpectedError
    case amiiboDetailUnexpectedError
    case amiiboNotFound
    case amiiboFavoriteListEmpty
    
    private static let amiiboLocalizable = "AmiiboLocalizable"
    
    public var errorDescription: String? {
        switch self {
        case .amiiboListUnexpectedError:
            return "amiiboFavoriteListEmpty".localized(tableName: AmiiboException.amiiboLocalizable)
        case .amiiboDetailUnexpectedError:
            return "amiiboDetailUnexpectedError".localized(tableName: AmiiboException.amiiboLocalizable)
        case .amiiboNotFound:
            return "amiiboNotFound".localized(tableName: AmiiboException.amiiboLocalizable)
        case .amiiboFavoriteListEmpty:
            return "amiiboFavoriteListEmpty".localized(tableName: AmiiboException.amiiboLocalizable)
        }
    }
}
