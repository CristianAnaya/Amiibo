//
//  AmiiboAlamofireRepository.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation
import Combine
import Domain
import Alamofire

class AmiiboAlamofireRepository: AmiiboRemoteRepository {
    
    private let httpClient: HttpClient
    
    init(httpClient: HttpClient) {
        self.httpClient = httpClient
    }
    
    func getAmiiboList() throws -> AnyPublisher<[Amiibo], Error> {
        let request = GetAmiiboListRequest(object: nil, path: nil)
        
        return httpClient.requestGeneric(
            request: request,
            entity: AmiiboListResponse.self,
            queue: .global(),
            retries: 1
        )
        .tryMap { amiiboListResponse in
            return try amiiboListResponse.amiibo.compactMap { amiiboDto in
                do {
                    return try AmiiboMapper.fromDtoToDomain(amiiboDto: amiiboDto)
                } catch {
                    throw error
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func getAmiiboDetail(head: String, tail: String) throws -> AnyPublisher<Amiibo?, Error> {
        let request = GetAmiiboDetailRequest(object: nil, path: "\(head)\(tail)")
        
        return httpClient.requestGeneric(
            request: request,
            entity: AmiiboDetailResponse.self,
            queue: .global(),
            retries: 1
        )
        .tryMap { amiiboDetailResponse in
            return try AmiiboMapper.fromDtoToDomain(amiiboDto: amiiboDetailResponse.amiibo)
        }
        .eraseToAnyPublisher()
    }
    
}
