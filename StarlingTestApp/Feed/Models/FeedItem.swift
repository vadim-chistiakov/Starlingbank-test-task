//
//  FeedItem.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

struct FeedItem: Decodable {
    struct Amount: Decodable {
        let currency: String
        let minorUnits: Int
    }
    
    enum Direction: String, Decodable {
        case OUT
        case `IN`
    }
    
    let counterPartyName: String
    let amount: Amount
    let direction: Direction
    let spendingCategory: String
}
