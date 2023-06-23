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
    
    public func invoke(head: String, tail: String) -> AnyPublisher<Amiibo?, Error>  {
        return amiiboRepository.getDetail(head: head, tail: tail)
            .flatMap { amiibo -> AnyPublisher<Amiibo?, Error> in

                guard amiibo != nil else {
                    return Fail(error: AmiiboException.amiiboNotFound).eraseToAnyPublisher()
                }
                print("ENTRO POR ACA")
                return Just(amiibo).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
