//
//  NetworkClientDefaultImpl.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

final class NetworkClientDefaultImpl: NetworkClient {
    
    func sendRequest<T: Decodable>(
        endpoint: any Endpoint,
        responseModelType: T.Type
    ) async throws -> T {
        
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme.rawValue
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.params
        
        let request = Request(
            urlComponents: urlComponents,
            headers: endpoint.header,
            reqBody: endpoint.body,
            httpMethod: endpoint.method
        )
        
        guard let urlRequest = request.buildURLRequest() else {
            throw RequestError.urlMalformed
        }
        
        print("Url request: \(urlRequest.description)")
        print("Url request headers: \(urlRequest.allHTTPHeaderFields ?? [:])")

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw RequestError.noResponse
            }

            print("ResponseStatusCode: \(httpResponse.statusCode)")

            guard 200..<300 ~= httpResponse.statusCode else {
                throw RequestError(fromHttpStatusCode: httpResponse.statusCode)
            }
            
            let json = try? JSONSerialization.jsonObject(
                with: data,
                options: []
            ) as? [String: Any]
            print("data \(data)")
            print("json output \(json ?? [:])")

            
            switch httpResponse.statusCode {
            case 200...299:
                let decoder = JSONDecoder()
                decoder.dataDecodingStrategy = .base64
                
                do {
                    let decodedResponse = try decoder.decode(
                        responseModelType,
                        from: data
                    )
                    return decodedResponse
                } catch {
                    throw RequestError.decodingError(String(describing: error))
                }
            default:
                throw RequestError.unknown("Unknown status code")
            }
        } catch {
            throw handleError(urlRequest, error)
        }
    }
    
    private func handleError(
        _ request: URLRequest,
        _ error: Error
    ) -> RequestError {
        if let error = error as? RequestError {
            return error
        }
        let errorCode = (error as NSError).code
        switch errorCode {
        case NSURLErrorTimedOut:
            return RequestError.timeout
        case NSURLErrorNotConnectedToInternet, NSURLErrorDataNotAllowed:
            return RequestError.noConnection
        case NSURLErrorNetworkConnectionLost:
            return RequestError.lostConnection
        default:
            return RequestError.unknown(error.localizedDescription)
        }
    }
}
