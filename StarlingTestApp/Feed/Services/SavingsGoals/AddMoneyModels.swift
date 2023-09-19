//
//  AddMoneyResponse.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

struct AddMoneyRequest: Encodable {
    let amount: FeedItem.Amount
}

struct AddMoneyResponse: Decodable {
    let success: Bool
    let transferUid: String
}
