//
//  NetworkLayer.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

protocol GetEndpoint: Endpoint {}

extension GetEndpoint {
    var method: RequestMethod {
        .get
    }
    
    var body: Body? {
        nil
    }
}
