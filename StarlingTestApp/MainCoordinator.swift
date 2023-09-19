//
//  MainCoordinator.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import UIKit

protocol Coordinator {
    func run(_ navigationController: UINavigationController)
}

final class MainCoordinator: Coordinator {
    
    private weak var navigationController: UINavigationController?

    func run(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        let viewController = FeedItemsViewController()
        let feedService = FeedServiceImpl()
        let feedPresenter = FeedPresenter(
            feedService: feedService,
            view: viewController
        )
        viewController.set(feedPresenter)
        navigationController.pushViewController(viewController, animated: false)
    }

}
