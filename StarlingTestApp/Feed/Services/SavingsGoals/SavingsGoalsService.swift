//
//  SavingsGoalsService.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

protocol SavingsGoalsService {
    func addMoneyToSavingsGoals(count: Int) async throws -> AddMoneyResponse
}

final class SavingsGoalsServiceImpl: NetworkClient, SavingsGoalsService {
    
    func addMoneyToSavingsGoals(count: Int) async throws -> AddMoneyResponse {
        try await sendRequest(
            endpoint: SavingsGoalsEndpoint.addMoney(
                accountId: "12fc273b-4d4d-4d00-a3d0-c5062488a2f6",
                savingsGoalsId: "173c8df5-f02d-436d-9f79-88efea0e9a91",
                count: count
            ),
            responseModelType: AddMoneyResponse.self
        )
    }
    
}
