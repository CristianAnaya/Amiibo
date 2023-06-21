//
//  LocalizedHelper.swift
//  Domain
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation

extension String {
    
    func localized(tableName: String) -> String {
        return Bundle.DomainFramework.localizedString(forKey: self,
                                           value: "**\(self)**",
                                           table: tableName)
    }
    
}
