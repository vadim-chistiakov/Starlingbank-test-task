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
        let feedPresenter = FeedPresenter(
            feedService: FeedServiceImpl(),
            savingsGoalsService: SavingsGoalsServiceImpl()
        )
        let viewController = FeedItemsViewController(presenter: feedPresenter)
        navigationController.pushViewController(viewController, animated: false)
    }

}
