//
//  HelpCenterCategoryViewController.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 19/07/24.
//

import Combine
import UIKit

class HelpCenterCategoryViewController: UIViewController, Loadable {

    private let contentView: HelpCenterCategoryView
    private let viewModel: HelpCenterCategoryViewModel
    
    private var cancellables = Set<AnyCancellable>()
    private var isFirstAppearing = true

    init(viewModel: HelpCenterCategoryViewModel) {
        contentView = HelpCenterCategoryView()
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        cancellables.forEach { $0.cancel() }
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isFirstAppearing {
            contentView.animateTransition(isAppearing: true) { [weak self] in
                guard let self = self else { return }
                self.isFirstAppearing = false
            }
        }
    }
    
    private func setupNavigationBar() {
        if let navigationBar = navigationController?.navigationBar {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.backgroundColor = .estaparPrimary
            navigationBarAppearance.shadowColor = .none
            navigationBarAppearance.titleTextAttributes = [
                .foregroundColor: UIColor.estaparWhite,
                .font: UIFont.estaparBold(size: .font16)
            ]
            
            navigationBar.standardAppearance = navigationBarAppearance
            navigationBar.compactAppearance = navigationBarAppearance
            navigationBar.scrollEdgeAppearance = navigationBarAppearance
            navigationBar.compactScrollEdgeAppearance = navigationBarAppearance
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: .arrowBack,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        navigationItem.leftBarButtonItem?.tintColor = .estaparWhite
    }
    
    private func bind() {
        // Loading event
        viewModel.$isLoading.sink { [weak self] isLoading in
            guard let self = self else { return }
            isLoading ? self.showLoading() : self.hideLoading()
        }.store(in: &cancellables)
        
        // Update Title event
        viewModel.$title
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.title = self.viewModel.title
        }.store(in: &cancellables)
        
        // First API call
        viewModel.fetchCategory()
    }
    
    @objc func backButtonTapped() {
        contentView.animateTransition(isAppearing: false) { [weak self] in
            guard let self = self else { return }
            self.viewModel.goBackToHome()
        }
    }
}
