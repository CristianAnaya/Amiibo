//
//  GetAmiiboDetailUseCase.swift
//  Domain
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation
import Combine

public class GetAmiiboDetailUseCase {
    private let amiiboRepository: AmiiboRepository
    
    public init(amiiboRepository: AmiiboRepository) {
        self.amiiboRepository = amiiboRepository
    }
    
    public func invoke(head: String, tail: String)  {
        
    }
}
