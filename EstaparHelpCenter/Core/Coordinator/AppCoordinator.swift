//
//  AppCoordinator.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import UIKit

class AppCoordinator {

    private let window: UIWindow
    private(set) var childCoordinator: CoordinatorProtocol?

    init(window: UIWindow) {
        self.window = window
    }

    func start() {
        // TODO: Go to Home
        window.rootViewController = UIViewController()
        window.makeKeyAndVisible()
    }
}
