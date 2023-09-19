//
//  GetEndpoint.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

protocol GetEndpoint: Endpoint where Body == EmptyBody {}

struct EmptyBody: Encodable {}

extension GetEndpoint {
    
    var method: RequestMethod {
        .get
    }
    
    var body: Body? {
        nil
    }
}
