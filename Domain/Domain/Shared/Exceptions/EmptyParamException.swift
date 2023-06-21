//
//  EmptyParamException.swift
//  Domain
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation


public enum EmptyParamException: Error, LocalizedError, Equatable {
    case emptyField

    public var errorDescription: String? {
        switch self {
        case .emptyField:
            return "emptyParam".localized(tableName: "DomainSharedLocalizable")
        }
    }
    
}
