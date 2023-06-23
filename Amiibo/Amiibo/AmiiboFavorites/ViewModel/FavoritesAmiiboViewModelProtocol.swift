//
//  AmiiboFavoritesViewModelProtocol.swift
//  Amiibo
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 22/06/23.
//

import Foundation
import Domain

protocol FavoriteAmiiboViewModelProtocol {
    var isLoading: Bool { get }
    var favoriteAmiiboList: [Amiibo] { get }
    var errorMessage: String? { get }

    func fetchFavoritesAmiibo()
}
