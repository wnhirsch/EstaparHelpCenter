//
//  HomeViewController.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import Combine
import UIKit

class HomeViewController: UIViewController {

    private let contentView: HomeView
    private let coordinator: HomeCoordinator
    
    private var cancellables = Set<AnyCancellable>()

    init(coordinator: HomeCoordinator) {
        self.coordinator = coordinator
        contentView = HomeView()
        super.init(nibName: nil, bundle: nil)
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        coordinator.showHelpCenter() // Initialize Help Center flow
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func bind() {
        // Help Center Button clicked
        contentView.helpCenterPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            self.coordinator.showHelpCenter()
        }.store(in: &cancellables)
    }
}
