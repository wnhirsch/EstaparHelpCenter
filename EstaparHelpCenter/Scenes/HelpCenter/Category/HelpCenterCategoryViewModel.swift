//
//  HelpCenterCategoryViewModel.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 19/07/24.
//

import Combine

class HelpCenterCategoryViewModel {
    
    private weak var coordinator: HelpCenterCoordinator?
    private let worker: HelpCenterWorker
    private let categoryId: String
    
    @Published var title: String = "helpcenter.home.title".localized
    @Published var sections = [HelpCenterCategoryModel.Section]()
    
    @Published var isLoading: Bool = false

    init(
        categoryId: String,
        coordinator: HelpCenterCoordinator,
        worker: HelpCenterWorker = .init()
    ) {
        self.categoryId = categoryId
        self.coordinator = coordinator
        self.worker = worker
    }
    
    func fetchCategory() {
        guard !isLoading else { return }
        isLoading = true
        
        worker.getCategory(id: categoryId) { [weak self] model in
            guard let self = self else { return }
            // Setup values
            self.title = model.title
            self.sections = model.items
            // Finish loading
            self.isLoading = false
        } failure: { [weak self] in
            guard let self = self else { return }
            // Finish loading
            self.isLoading = false
            // Show error
            self.coordinator?.showError() { [weak self] _ in
                guard let self = self else { return }
                // If user press try again, rerun the request
                self.fetchCategory()
            } cancel: { [weak self] _ in
                guard let self = self else { return }
                // If user press cancel, go back to Home
                self.goBackToHome()
            }
        }
    }
    
    func goBackToHome() {
        coordinator?.pop()
    }
}
