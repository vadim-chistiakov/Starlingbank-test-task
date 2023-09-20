//
//  FeedItem.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

struct FeedItems: Decodable {
    let feedItems: [FeedItem]
}

struct FeedItem: Hashable, Decodable {
    
    struct Amount: Hashable, Codable {
        let currency: String
        let minorUnits: Int64
    }
    
    enum Direction: String, Hashable, Decodable {
        case out = "OUT"
        case `in` = "IN"
    }
    
    let counterPartyName: String
    let amount: Amount
    let direction: Direction
    let spendingCategory: String
    let feedItemUid: String
}
