//
//  NetworkLayer.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

protocol PostEndpoint: Endpoint {}

extension PostEndpoint {
    var method: RequestMethod {
        .post
    }
}
