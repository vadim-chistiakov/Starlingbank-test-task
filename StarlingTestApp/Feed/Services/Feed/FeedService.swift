//
//  FeedService.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

protocol FeedService {
    func fetchAllFeedItems() async throws -> [FeedItem]
}

final class FeedServiceImpl: NetworkClient, FeedService {
    
    func fetchAllFeedItems() async throws -> [FeedItem] {
        try await sendRequest(
            endpoint: FeedItemsEndpoint.feedItems(
                accountId: "12fc273b-4d4d-4d00-a3d0-c5062488a2f6",
                categoryId: "12fcca98-4d0a-438c-bd1c-7ccc521c7914",
                changesSince: Date.distantPast
            ),
            responseModelType: FeedItems.self
        ).feedItems
    }
    
}
