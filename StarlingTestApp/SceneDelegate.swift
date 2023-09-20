//
//  SceneDelegate.swift
//  StarlingTestApp
//
//  Created by Vadim Chistiakov on 19.09.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)

        let rootNavigationController = UINavigationController()
        
        coordinator = MainCoordinator()
        coordinator?.run(rootNavigationController)
        
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }

}

