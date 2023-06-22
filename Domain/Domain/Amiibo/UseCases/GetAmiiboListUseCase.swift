//
//  GetAmiiboListUseCase.swift
//  Domain
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import Foundation
import Combine

public class GetAmiiboListUseCase {
    private let amiiboRepository: AmiiboRepository
    
    public init(amiiboRepository: AmiiboRepository) {
        self.amiiboRepository = amiiboRepository
    }
    
    public func invoke() -> AnyPublisher<[Amiibo], Error>  {
        return amiiboRepository.getAmiiboList()
            .flatMap { amiiboList -> AnyPublisher<[Amiibo], Error> in
                guard !amiiboList.isEmpty else {
                    return Fail(error: AmiiboException.emptyAmiiboList).eraseToAnyPublisher()
                }
                return Just(amiiboList).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
