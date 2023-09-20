//
//  Request.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

struct Request {
    
    let urlComponents: URLComponents
    let headers: Header?
    let body: Data?
    let requestTimeOut: Float?
    let httpMethod: RequestMethod
    
    init(
        urlComponents: URLComponents,
        headers: Header? = nil,
        reqBody: Encodable?,
        reqTimeout: Float? = nil,
        httpMethod: RequestMethod

    ) {
        self.urlComponents = urlComponents
        self.headers = headers
        self.body = reqBody?.encode()
        self.requestTimeOut = reqTimeout
        self.httpMethod = httpMethod
    }
    
    func buildURLRequest() -> URLRequest? {
        guard let url = urlComponents.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.allHTTPHeaderFields = headers ?? [:]
        urlRequest.httpBody = body
        return urlRequest
    }
}

private extension Encodable {
    func encode() -> Data? {
        do {
            return try JSONEncoder().encode(self)
        } catch {
            return nil
        }
    }
}
