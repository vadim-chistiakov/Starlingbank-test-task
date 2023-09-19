//
//  FeedItemsEndpoint.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

enum FeedItemsEndpoint {
    case feedItems(accountId: String, categoryId: String, changesSince: Date)
}

extension FeedItemsEndpoint: GetEndpoint {
    
    var path: String {
        switch self {
        case .feedItems(let accountId, let categoryId, _):
            return "/api/v2/feed/account/\(accountId)/category/\(categoryId)"
        }
    }
    
    var params: [URLQueryItem]? {
        switch self {
        case .feedItems(_,_, let changesSince):
            return [
                .init(name: "changesSince", value: "\(changesSince.ISO8601Format())")
            ]
        }
    }

}
