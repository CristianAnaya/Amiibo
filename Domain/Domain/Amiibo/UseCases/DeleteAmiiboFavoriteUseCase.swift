//
//  DeleteAmiiboFavoriteUseCase.swift
//  Domain
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import Foundation
import Combine

public class DeleteAmiiboFavoriteUseCase {
    private let amiiboRepository: AmiiboRepository
    
    public init(amiiboRepository: AmiiboRepository) {
        self.amiiboRepository = amiiboRepository
    }
    
    public func invoke(head: String, tail: String) throws -> AnyPublisher<Void, Error>  {
        return try amiiboRepository.deleteFavorite(head: head, tail: tail)
    }
}
