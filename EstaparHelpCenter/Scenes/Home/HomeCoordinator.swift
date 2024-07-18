//
//  HomeCoordinator.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import UIKit

class HomeCoordinator: Coordinator {

    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HomeViewController(coordinator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showHelpCenter() {
        let helpCenterCoordinator = HelpCenterCoordinator(navigationController: navigationController)
        childCoordinators.append(helpCenterCoordinator)
        helpCenterCoordinator.start()
    }
}
