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
    
    func showError(
        tryAgain: ((UIAlertAction) -> Void)? = nil,
        cancel: ((UIAlertAction) -> Void)? = nil
    ) {
        let alert = UIAlertController(
            title: "error.title".localized,
            message: "error.message".localized,
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(
            title: "error.cancel".localized,
            style: .cancel,
            handler: cancel
        )
        alert.addAction(cancelAction)
        
        let tryAgainAction = UIAlertAction(
            title: "error.tryAgain".localized,
            style: .default,
            handler: tryAgain
        )
        alert.addAction(tryAgainAction)
        
        navigationController.visibleViewController?.present(alert, animated: true)
    }
    
    func dismiss() {
        navigationController.dismiss(animated: true)
    }
}
