//
//  SaveAmiiboFavoriteUseCase.swift
//  Domain
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import Foundation
import Combine

public class SaveAmiiboFavoriteUseCase {
    private let amiiboRepository: AmiiboRepository
    
    public init(amiiboRepository: AmiiboRepository) {
        self.amiiboRepository = amiiboRepository
    }
    
    public func invoke(amiibo: Amiibo) -> AnyPublisher<Void, Error>  {
        return amiiboRepository.saveFavorite(amiibo: amiibo)
    }
}
