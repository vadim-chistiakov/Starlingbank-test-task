//
//  Endpoint.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

typealias Header = [String: String]

protocol Endpoint {
    associatedtype Body: Encodable
    
    var method: RequestMethod { get }
    var header: Header? { get }
    var scheme: Scheme { get }
    var host: String { get }
    var path: String { get }
    var body: Body? { get }
    var params: [URLQueryItem]? { get }
}

extension Endpoint {
    var scheme: Scheme {
        .https
    }
    
    var header: Header? {
        [
            "Authorization": Constants.bearer,
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
    }
    
    var host: String {
        "api-sandbox.starlingbank.com"
    }
    
}
