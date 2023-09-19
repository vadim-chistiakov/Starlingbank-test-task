//
//  FeedPresenter.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

final class FeedPresenter {
    
    var dataSource: DataSource?
    var isRefreshing: Bool = false

    private let feedService: FeedService
    private let savingsGoalsService: SavingsGoalsService
    private var snapshot: DataSourceSnapshot
        
    init(
        feedService: FeedService,
        savingsGoalsService: SavingsGoalsService,
        snapshot: DataSourceSnapshot = DataSourceSnapshot()
    ) {
        self.feedService = feedService
        self.savingsGoalsService = savingsGoalsService
        self.snapshot = snapshot
    }
    
    func fetchFeedItems(animatingDifferences: Bool) {
        Task {
            do {
                isRefreshing = true
                let feedItems = try await feedService.fetchAllFeedItems()
                configureDataSource(feedItems: feedItems, animatingDifferences: animatingDifferences)
            } catch {
                print("custom error \((error as? RequestError).debugDescription)")
            }
        }
    }
    
    func transferToSavings() {
        Task {
            try await savingsGoalsService.addMoneyToSavingsGoals(count: 100)
        }
    }
    
    //MARK: - Private methods
    
    private func configureDataSource(feedItems: [FeedItem], animatingDifferences: Bool) {
        snapshot.deleteAllItems()
        snapshot.appendSections(Section.allCases)
        
        snapshot.appendItems(feedItems, toSection: .feed)
        dataSource?.apply(snapshot, animatingDifferences: animatingDifferences)
        isRefreshing = false
    }
}
