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
        let minorUnits: Int
    }
    
    enum Direction: String, Hashable, Decodable {
        case OUT
        case `IN`
    }
    
    let counterPartyName: String
    let amount: Amount
    let direction: Direction
    let spendingCategory: String
    let feedItemUid: String
}
