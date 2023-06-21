//
//  AmiiboProxy.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation
import Domain
import Combine

struct AmiiboProxy: AmiiboRepository {
    private let amiiboLocalRepository: AmiiboLocalRepository
    private let amiiboRemoteRepository: AmiiboRemoteRepository
    private let networkVerify: NetworkVerify
    
    init(
        amiiboLocalRepository: AmiiboLocalRepository,
        amiiboRemoteRepository: AmiiboRemoteRepository,
        networkVerify: NetworkVerify
    ) {
        self.amiiboLocalRepository = amiiboLocalRepository
        self.amiiboRemoteRepository = amiiboRemoteRepository
        self.networkVerify = networkVerify
    }
    
    func getDetail(id: Int) -> AnyPublisher<Domain.Amiibo?, Error> {
        <#code#>
    }
    
    func getAmiiboList() -> AnyPublisher<[Domain.Amiibo], Error> {
        <#code#>
    }
    
    func getFavoriteAmiiboList() -> AnyPublisher<[Domain.Amiibo], Error> {
        <#code#>
    }
}
