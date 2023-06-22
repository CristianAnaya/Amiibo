//
//  GetAmiiboDetailRequest.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 21/06/23.
//

import Foundation
import Alamofire

struct GetAmiiboDetailRequest: HttpClientRequest {
    typealias Object = Any?
    let baseURL: String = Bundle.main.object(forInfoDictionaryKey: "BaseURL") as? String ?? ""
    let path: String?
    var endpoint: String { baseURL + "/amiibo/?id=\(path!)" }
    var httpHeaders: [String: String] = [:]
    var params: [String: Any]?
    var httpMethod: Alamofire.HTTPMethod = .get
    
    init(object: Any?, path: String?) {
        self.path = path
    }
}
