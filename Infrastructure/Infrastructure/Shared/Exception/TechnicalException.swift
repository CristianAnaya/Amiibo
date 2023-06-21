//
//  TechnicalException.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation


public enum TechnicalException: Error, LocalizedError, Equatable {
    case technicalError
    
    private static let technicalExceptionMessage: String = "technicalExceptionMessage"
    
    public var errorDescription: String? {
        switch self {
        case .technicalError:
            return TechnicalException.technicalExceptionMessage.localized(tableName: "")
        }
        
    }
}
