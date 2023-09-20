//
//  SavingsGoalsService.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

protocol SavingsGoalsService {
    func addMoneyToSavingsGoals(
        accountId: String,
        savingsGoalsId: String,
        count: Int64
    ) async throws -> AddMoneyResponse
}

final class SavingsGoalsServiceImpl: NetworkClient, SavingsGoalsService {
    
    func addMoneyToSavingsGoals(
        accountId: String,
        savingsGoalsId: String,
        count: Int64
    ) async throws -> AddMoneyResponse {
        try await sendRequest(
            endpoint: SavingsGoalsEndpoint.addMoney(
                accountId: accountId,
                savingsGoalsId: savingsGoalsId,
                count: count
            ),
            responseModelType: AddMoneyResponse.self
        )
    }
    
}
