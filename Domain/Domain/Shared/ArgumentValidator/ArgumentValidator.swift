//
//  ArgumentValidator.swift
//  Domain
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation

public class ArgumentValidator {
    
    static func validateEmptyParam(value: String) throws {
        if value.isEmpty {
            throw EmptyParamException.emptyField
        }
    }
    
}
