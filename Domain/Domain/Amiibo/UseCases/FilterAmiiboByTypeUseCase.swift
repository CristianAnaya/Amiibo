//
//  FilterAmiiboByTypeUseCase.swift
//  Domain
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 22/06/23.
//

import Foundation
import Combine

public class FilterAmiiboByTypeUseCase {
    private let amiiboRepository: AmiiboRepository
    
    public init(amiiboRepository: AmiiboRepository) {
        self.amiiboRepository = amiiboRepository
    }
    
    public func invoke(type: String) -> AnyPublisher<[Amiibo], Error>  {
        return amiiboRepository.filerAmiiboByType(type: type)
            .flatMap { amiiboList -> AnyPublisher<[Amiibo], Error> in
                guard !amiiboList.isEmpty else {
                    return Fail(error: AmiiboException.emptyAmiiboList).eraseToAnyPublisher()
                }
                
                let sortedAmiiboList = amiiboList.sorted { $0.name < $1.name }
                return Just(sortedAmiiboList).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
