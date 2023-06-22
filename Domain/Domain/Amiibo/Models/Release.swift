//
//  Release.swift
//  Domain
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation

public struct Release: Equatable {
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
    
    public var formattedAU: String? {
        return formatDate(au)
    }
    
    public var formattedEU: String? {
        return formatDate(eu)
    }
    
    public var formattedJP: String? {
        return formatDate(jp)
    }
    
    public var formattedNA: String? {
        return formatDate(na)
    }
    
    private func formatDate(_ dateString: String?) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let dateString = dateString, let date = dateFormatter.date(from: dateString) else {
            return "No Disponible"
        }
        
        dateFormatter.dateFormat = "dd-MMM-yyyy"
        return dateFormatter.string(from: date)
    }
}





