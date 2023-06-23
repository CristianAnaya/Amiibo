//
//  AmiiboHomeViewModelProtocol.swift
//  Amiibo
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 22/06/23.
//

import Foundation
import Domain

protocol AmiiboHomeViewModelProtocol {
    var isLoading: Bool { get }
    var amiiboList: [Amiibo] { get }
    var errorMessage: String? { get }

    func fetchAmiiboList()
    func filterAmiiboByType(type: String)
}

