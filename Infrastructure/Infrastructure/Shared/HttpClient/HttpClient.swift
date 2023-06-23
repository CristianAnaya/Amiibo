//
//  HttpClient.swift
//  Infrastructure
//
//  Created by Cristian David Anaya Alba - Ceiba Software on 20/06/23.
//

import Combine
import Alamofire

final class HttpClient {
    let session: Session
    
    convenience init () {
        let configuration: URLSessionConfiguration = URLSession.configuration()
        self.init(configuration: configuration)
    }
    
    init(configuration: URLSessionConfiguration) {
        self.session = Session(configuration: configuration)
    }
    
    func requestGeneric<R: HttpClientRequest, T: Decodable>(
        request: R,
        entity: T.Type,
        queue: DispatchQueue,
        retries: Int = 0
    ) -> AnyPublisher<T, HttpClientException> {
        let headers = HTTPHeaders(request.httpHeaders)
        let method = request.httpMethod
        return session.request(request.endpoint, method: method, parameters: request.params, headers: headers)
            .validate()
            .response { result in
                debugPrint(result)
            }
            .publishDecodable(type: T.self)
            .value()
            .retry(retries)
            .receive(on: queue)
            .mapError { self.evaluateError($0)}
            .eraseToAnyPublisher()
    }
    
    private func evaluateError(_ error: AFError) -> HttpClientException {
        if let code = error.responseCode {
            return HttpClientException(errorCode: code)
        } else {
            return HttpClientException(status: .unknown)
        }
    }
}
