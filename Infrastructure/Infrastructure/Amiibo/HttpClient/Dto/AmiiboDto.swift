//
//  AmiiboDto.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation

struct AmiiboDto: Codable {
    let head: String
    let tail: String
    let name: String
    let amiiboSeries: String
    let type: String
    let image: String
    let character: String
    let release: ReleaseDto
}
