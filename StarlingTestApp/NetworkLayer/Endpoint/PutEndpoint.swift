//
//  PutEndpoint.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

protocol PutEndpoint: Endpoint {}

extension PutEndpoint {
    
    var method: RequestMethod {
        .put
    }
    
    var params: [URLQueryItem]? {
        nil
    }
}
