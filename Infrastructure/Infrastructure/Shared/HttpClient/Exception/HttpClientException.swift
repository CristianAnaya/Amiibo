//
//  HttpClientException.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Foundation

public struct HttpClientException: Error, LocalizedError {
    public var status: StatusCodes
    public var code: Int { return status.rawValue }
    public var errorDescription: String?
    
    public init(errorCode: Int) {
        status = StatusCodes(rawValue: errorCode) ?? .unknown
        errorDescription = description
    }
    
    public init(errorCode: Int, decription: String) {
        status = StatusCodes(rawValue: errorCode) ?? .unknown
        errorDescription = description
    }
    
    public init(status: StatusCodes) {
        self.status = status
        errorDescription = description
    }
    
    public enum StatusCodes: Int {
        
        case unknown                        = -1
        
        // Success
        case ok                             = 200
        
        // Client Error
        case badRequest                     = 400
        case unauthorized                   = 401
        case notFound                       = 404
        case requestTimeout                 = 408
        
        // Server Error
        case internalServerError            = 500
        case notImplemented                 = 501

        // Internal Error
        case timedOut                       = -1001
        case notConnectedToInternet         = -1009
        
    }
}

extension HttpClientException: CustomStringConvertible {
    public var description: String {
        return String(describing: self.status)
            .replacingOccurrences(of: "(?<=[a-z])(?=[A-Z])|(?<=[A-Z])(?=[A-Z][a-z])",
                                  with: " ",
                                  options: [.regularExpression])
            .capitalized
    }
    
}
