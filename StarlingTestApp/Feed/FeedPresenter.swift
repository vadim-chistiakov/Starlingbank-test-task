//
//  FeedPresenter.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

final class FeedPresenter {
    
    private let feedService: FeedService
    private weak var view: PresenterView?
    
    init(
        feedService: FeedService,
        view: PresenterView
    ) {
        self.feedService = feedService
        self.view = view
    }
    
    func fetchFeedItems() {
        Task {
            let feedItems = try await feedService.fetchAllFeedItems()
            view?.didFinishFetching()
            print(feedItems)
        }
    }
}
