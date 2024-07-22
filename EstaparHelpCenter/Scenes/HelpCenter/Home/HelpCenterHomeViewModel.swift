//
//  HelpCenterHomeViewModel.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import Combine
import Foundation

class HelpCenterHomeViewModel {
    
    private weak var coordinator: HelpCenterCoordinator?
    private let worker: HelpCenterWorker
    
    private let firstName: String = "Wellington"
    
    @Published var imageURL: URL? = nil
    @Published var line1: String = ""
    @Published var line2: String = ""
    @Published var categories = [HelpCenterHomeModel.Category]()
    
    @Published var isLoading: Bool = false

    init(coordinator: HelpCenterCoordinator, worker: HelpCenterWorker = .init()) {
        self.coordinator = coordinator
        self.worker = worker
    }
    
    func goToCategory(index: Int) {
        coordinator?.startCategory(categoryId: categories[index].id)
    }
    
    func fetchCategories() {
        guard !isLoading else { return }
        isLoading = true
        
        worker.getCategories(success: { [weak self] model in
            guard let self = self else { return }
            // Setup values
            self.setImageURL(newValue: model.header.image)
            self.line1 = model.header.line1.replacingOccurrences(of: "%firstName%", with: firstName)
            self.line2 = model.header.line2
            self.categories = model.items
            // Finish loading
            self.isLoading = false
        }, failure: { [weak self] in
            guard let self = self else { return }
            // Finish loading
            self.isLoading = false
            // Show error
            self.coordinator?.showError() { [weak self] _ in
                guard let self = self else { return }
                // If user press try again, rerun the request
                self.fetchCategories()
            } cancel: { [weak self] _ in
                guard let self = self else { return }
                // If user press cancel, close the modal
                self.coordinator?.dismiss()
            }
        })
    }
    
    private func setImageURL(newValue: HelpCenterHeaderModel.ImageSizes) {
        if newValue.size3.isEmpty {
            if newValue.size2.isEmpty {
                if newValue.size2.isEmpty {
                    self.imageURL = nil
                } else {
                    self.imageURL = URL(string: newValue.size1)
                }
            } else {
                self.imageURL = URL(string: newValue.size2)
            }
        } else {
            self.imageURL = URL(string: newValue.size3)
        }
    }
}
