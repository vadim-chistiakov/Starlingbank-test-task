//
//  NetworkLayer.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

protocol NetworkClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModelType: T.Type
    ) async -> Result<T, RequestError>
}
