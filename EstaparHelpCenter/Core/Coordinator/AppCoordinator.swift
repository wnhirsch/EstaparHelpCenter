//
//  AppCoordinator.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import UIKit

class AppCoordinator {

    private let window: UIWindow
    var navigationController = UINavigationController()
    private(set) var childCoordinator: Coordinator?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        let homeCoordinator = HomeCoordinator(navigationController: navigationController)
        homeCoordinator.start()
        childCoordinator = homeCoordinator
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
