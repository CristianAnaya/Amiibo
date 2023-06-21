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
        
    }
    
    func getAmiiboDetail() throws -> AnyPublisher<Amiibo?, Error> {
        
    }
    
}
