//
//  AmiiboException.swift
//  Domain
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation

public enum AmiiboException: Error, LocalizedError, Equatable {
    case emptyAmiiboList
    case amiiboNotFound
    case emptyAmiiboFavoriteList
    
    private static let amiiboLocalizable = "AmiiboLocalizable"
    
    public var errorDescription: String? {
        switch self {
        case .emptyAmiiboList:
            return "emptyAmiiboList".localized(tableName: AmiiboException.amiiboLocalizable)
        case .amiiboNotFound:
            return "amiiboNotFound".localized(tableName: AmiiboException.amiiboLocalizable)
        case .emptyAmiiboFavoriteList:
            return "emptyAmiiboFavoriteList".localized(tableName: AmiiboException.amiiboLocalizable)
        }
    }
}
