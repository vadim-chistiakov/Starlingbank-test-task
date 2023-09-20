//
//  FeedService.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

protocol FeedService {
    func fetchAllFeedItems(accountId: String, categoryId: String) async throws -> [FeedItem]
}

final class FeedServiceImpl: NetworkClient, FeedService {
    
    private let calendar: Calendar
    
    private lazy var oneWeekAgo: Date = {
        calendar.date(byAdding: .weekOfYear, value: -1, to: Date()) ?? .distantPast
    }()
    
    init(calendar: Calendar) {
        self.calendar = calendar
    }
    
    func fetchAllFeedItems(accountId: String, categoryId: String) async throws -> [FeedItem] {
        try await sendRequest(
            endpoint: FeedItemsEndpoint.feedItems(
                accountId: accountId,
                categoryId: categoryId,
                changesSince: oneWeekAgo
            ),
            responseModelType: FeedItems.self
        ).feedItems
    }
    
}
