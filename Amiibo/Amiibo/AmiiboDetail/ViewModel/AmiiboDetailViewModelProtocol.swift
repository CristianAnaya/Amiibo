//
//  AmiiboDetailViewModelProtocol.swift
//  Amiibo
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 22/06/23.
//

import Foundation
import Domain

protocol AmiiboDetailViewModelProtocol {
    var isLoading: Bool { get }
    var amiibo: Amiibo? { get }
    var errorMessage: String? { get }
    
    func saveAmiibo()
    func fetchAmiibo()
}
