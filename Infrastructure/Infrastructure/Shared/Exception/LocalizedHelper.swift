//
//  LocalizedHelper.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation

public extension String {
    
    func localized(tableName: String) -> String {
        return Bundle.InfrastructureFramework.localizedString(forKey: self,
                                           value: "**\(self)**",
                                           table: tableName)
    }
}
