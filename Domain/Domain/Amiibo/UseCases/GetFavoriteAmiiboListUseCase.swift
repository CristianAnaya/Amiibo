//
//  GetFavoriteAmiiboListUseCase.swift
//  Domain
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import Foundation
import Combine

public class GetFavoriteAmiiboListUseCase {
    private let amiiboRepository: AmiiboRepository
    
    public init(amiiboRepository: AmiiboRepository) {
        self.amiiboRepository = amiiboRepository
    }
    
    public func invoke() throws -> AnyPublisher<[Amiibo], Error>  {
        return try amiiboRepository.getFavoriteAmiiboList()
            .flatMap { amiiboList -> AnyPublisher<[Amiibo], Error> in
                guard !amiiboList.isEmpty else {
                    return Fail(error: AmiiboException.emptyAmiiboFavoriteList).eraseToAnyPublisher()
                }
                return Just(amiiboList).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
