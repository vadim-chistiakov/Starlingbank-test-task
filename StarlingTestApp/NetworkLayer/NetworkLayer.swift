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
    ) async throws -> T
    
}

extension NetworkClient {
    
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModelType: T.Type
    ) async throws -> T {
        try await NetworkClientDefaultImpl().sendRequest(
            endpoint: endpoint,
            responseModelType: responseModelType
        )
    }
    
}
