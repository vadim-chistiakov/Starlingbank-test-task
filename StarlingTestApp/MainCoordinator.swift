//
//  MainCoordinator.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    func run(_ navigationController: UINavigationController)
    func showAlert(title: String, action: UIAlertAction)
}

final class MainCoordinator: Coordinator {
    
    private weak var navigationController: UINavigationController?

    func run(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        let feedPresenter = FeedPresenter(
            feedService: FeedServiceImpl(
                calendar: Calendar.current
            ),
            savingsGoalsService: SavingsGoalsServiceImpl(),
            currencyFormatter: CurrencyFormatterImpl(
                formatter: NumberFormatter()
            ),
            account: MockAccountData(),
            coordinator: self
        )
        let viewController = FeedItemsViewController(presenter: feedPresenter)
        navigationController.pushViewController(viewController, animated: false)
    }

    func showAlert(title: String, action: UIAlertAction) {
        let alert = UIAlertController(
            title: title,
            message: nil,
            preferredStyle: .alert
        )
        alert.addAction(action)
        navigationController?.topViewController?.present(alert, animated: true)
    }
}
