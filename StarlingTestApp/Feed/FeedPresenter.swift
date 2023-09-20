//
//  FeedPresenter.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation
import UIKit

final class FeedPresenter {
    
    var dataSource: DataSource?
    var applySnapshotCompletion: (() -> Void)?
    
    var moneyToSavingsGoalsFormatted: String {
        currencyFormatter.formatCurrency(minorUnits: moneyToSavingsGoals)
    }
    
    private var moneyToSavingsGoals: Int64 {
        currencyFormatter.roundedAmount(for: feedItems.map(\.amount))
    }

    private let feedService: FeedService
    private let savingsGoalsService: SavingsGoalsService
    private let currencyFormatter: CurrencyFormatter
    private let account: MockAccountData
    
    private weak var coordinator: Coordinator?
    
    private var feedItems: [FeedItem] = []
    private var snapshot: DataSourceSnapshot
        
    init(
        feedService: FeedService,
        savingsGoalsService: SavingsGoalsService,
        currencyFormatter: CurrencyFormatter,
        account: MockAccountData,
        coordinator: Coordinator,
        snapshot: DataSourceSnapshot = DataSourceSnapshot()
    ) {
        self.feedService = feedService
        self.savingsGoalsService = savingsGoalsService
        self.currencyFormatter = currencyFormatter
        self.account = account
        self.coordinator = coordinator
        self.snapshot = snapshot
    }
    
    func fetchFeedItems(animatingDifferences: Bool) {
        Task {
            do {
                feedItems = try await feedService.fetchAllFeedItems(
                    accountId: account.accountId,
                    categoryId: account.categoryId
                )
                configureDataSource(feedItems: feedItems, animatingDifferences: animatingDifferences)
            } catch {
                print("custom error \((error as? RequestError).debugDescription)")
            }
        }
    }
    
    func transferToSavings() {
        Task {
            do {
                let response = try await savingsGoalsService.addMoneyToSavingsGoals(
                    accountId: account.accountId,
                    savingsGoalsId: account.savingsGoalsId,
                    count: moneyToSavingsGoals
                )
                if !response.success {
                    throw RequestError.unknown("Saving was unsuccessful")
                }
                
                await MainActor.run {
                    coordinator?.showAlert(
                        title: "Saving was successful!",
                        action: UIAlertAction(title: "Ok", style: .default, handler: { [weak self] _ in
                            self?.fetchFeedItems(animatingDifferences: true)
                        })
                    )
                }
                
            } catch {
                await MainActor.run {
                    coordinator?.showAlert(
                        title: "Saving was unsuccessful. Try Again",
                        action: UIAlertAction(title: "Ok", style: .default)
                    )
                }
            }
        }
    }
    
    //MARK: - Private methods
    
    private func configureDataSource(feedItems: [FeedItem], animatingDifferences: Bool) {
        snapshot.deleteAllItems()
        snapshot.appendSections(Section.allCases)
        
        let cellModels = feedItems.map { feedItem in
            FeedItemCellModel(
                id: feedItem.feedItemUid,
                title: feedItem.counterPartyName,
                price: currencyFormatter.formatCurrency(amount: feedItem.amount),
                category: feedItem.spendingCategory
            )
        }
        snapshot.appendItems(cellModels, toSection: .feed)
        dataSource?.apply(
            snapshot,
            animatingDifferences: animatingDifferences,
            completion: applySnapshotCompletion
        )
    }
}
