//
//  SavingsGoalsEndpoint.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

enum SavingsGoalsEndpoint {
    case addMoney(accountId: String, savingsGoalsId: String, count: Int64)
}

extension SavingsGoalsEndpoint: PutEndpoint {
    typealias Body = AddMoneyRequest
        
    var path: String {
        switch self {
        case .addMoney(let accountId, let savingsGoalsId, _):
            return "/api/v2/account/\(accountId)/savings-goals/\(savingsGoalsId)/add-money/\(UUID().uuidString)"
        }
    }
    
    var body: Body? {
        switch self {
        case .addMoney(_,_, let count):
            return AddMoneyRequest(
                amount: FeedItem.Amount(
                    currency: "GBP",
                    minorUnits: count
                )
            )
        }
    }

}
