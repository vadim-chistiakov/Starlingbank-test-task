//
//  NetworkLayer.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

typealias Header = [String: String]
typealias Body = [String: String]

protocol Endpoint {
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
}
