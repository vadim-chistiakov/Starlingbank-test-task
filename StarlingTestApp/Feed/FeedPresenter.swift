//
//  FeedPresenter.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import Foundation

final class FeedPresenter {
    
    private let feedService: FeedService
    private var feedItems = [FeedItem]()
    
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
            do {
                feedItems = try await feedService.fetchAllFeedItems()
                view?.didFinishFetching()
            } catch {
                print("custom error \((error as? RequestError).debugDescription)")
            }
        }
    }
}
