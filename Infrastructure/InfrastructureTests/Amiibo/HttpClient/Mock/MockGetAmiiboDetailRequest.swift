//
//  MockGetAmiiboDetailRequest.swift
//  InfrastructureTests
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import Foundation
import Alamofire
@testable import Infrastructure

class MockGetAmiiboDetailRequest: HttpClientRequest {
    typealias Model = Any?
    
    let baseURL: String = "https://www.amiiboapi.com/api"
    let path: String?
    var endpoint: String { baseURL + "/amiibo/?id=\(path!)" }
    var httpHeaders: [String: String] = [:]
    var params: [String: Any]?
    var httpMethod: Alamofire.HTTPMethod = .get
    
    required init(object: Any?, path: String?) {
        self.path = path
    }
}
