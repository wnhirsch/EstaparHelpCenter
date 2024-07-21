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
        setupKeyboardDismissEvent()
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
    
    func setupKeyboardDismissEvent() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
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
        navigationItem.leftBarButtonItem?.tintColor = .clear
        
        UIView.animate(withDuration: .alpha30, delay: .zero, options: .curveEaseOut) {
            self.navigationItem.leftBarButtonItem?.tintColor = .estaparWhite
        }
    }
    
    private func bind() {
        contentView.searchField.delegate = self
        
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
                self.setTitleWithFade(self.viewModel.title)
        }.store(in: &cancellables)
        
        // First API call
        viewModel.fetchCategory()
    }
    
    @objc func backButtonTapped() {
        // Animate Navigation Bar
        setTitleWithFade(nil) // Hide title
        UIView.animate(withDuration: .alpha30, delay: .zero, options: .curveEaseOut) {
            self.navigationItem.leftBarButtonItem?.tintColor = .clear // Hide back button
        }
        
        // Animate View
        contentView.animateTransition(isAppearing: false) { [weak self] in
            guard let self = self else { return }
            self.viewModel.goBackToHome()
        }
    }
    
    @objc func dismissKeyboard() {
        contentView.searchField.resignFirstResponder()
    }
}

extension HelpCenterCategoryViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        contentView.animateSearchFieldBorder(isFocused: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        contentView.animateSearchFieldBorder(isFocused: false)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var newText = textField.text ?? ""
        let firstIndex = newText.index(newText.startIndex, offsetBy: range.lowerBound)
        let lastIndex = newText.index(newText.startIndex, offsetBy: range.upperBound)
        newText.replaceSubrange(firstIndex..<lastIndex, with: string)
        
        // TODO: Search Algorithm
        
        return true
    }
}
