//
//  HelpCenterCoordinator.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import UIKit

class HelpCenterCoordinator: Coordinator {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    var modalNavigationController = UINavigationController()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = HelpCenterHomeViewController(viewModel: .init(coordinator: self))
        modalNavigationController = UINavigationController(rootViewController: vc)
        navigationController.present(modalNavigationController, animated: true, completion: nil)
    }
    
    func startCategory(categoryId: String) {
        let vc = UIViewController()
        modalNavigationController.pushViewController(vc, animated: true)
    }
}
