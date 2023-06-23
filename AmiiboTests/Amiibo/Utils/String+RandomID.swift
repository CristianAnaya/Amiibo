//
//  String+RandomID.swift
//  AmiiboTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 23/06/23.
//

import Foundation

extension String {

    static var randomID: Self {
        String(String.randomString)
    }

    static var randomString: Self {
        UUID().uuidString
    }

}
