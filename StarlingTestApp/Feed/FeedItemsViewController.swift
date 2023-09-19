//
//  FeedItemsViewController.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import UIKit

protocol PresenterView: AnyObject {
    func didFinishFetching()
}

final class FeedItemsViewController: UIViewController {
    
    private var presenter: FeedPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchFeedItems()
    }

}

extension FeedItemsViewController {
    func set(_ presenter: FeedPresenter) {
        self.presenter = presenter
    }
}

extension FeedItemsViewController: PresenterView {
    
    @MainActor
    func didFinishFetching() {
        
    }
}
