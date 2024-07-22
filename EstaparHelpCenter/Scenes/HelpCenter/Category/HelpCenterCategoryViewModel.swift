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
    
    @Published var title: String = ""
    @Published var filteredSections = [HelpCenterCategoryModel.Section]()
    
    private var sections = [HelpCenterCategoryModel.Section]()
    private var hiddenSections = [Int]()
    
    @Published var isFiltering: Bool = false
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
            self.filteredSections = model.items
            self.hiddenSections = Array(0..<model.items.count)
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
    
    func filterSections(by text: String) {
        isFiltering = !text.isEmpty
        
        guard !text.isEmpty else { // If there is no filter, reset
            self.filteredSections = sections
            return
        }
        
        // Get the original value from the API
        var filteredSections = self.sections
        // Clean the typed text and transform it in an array of words
        // Example: "  ConStelaçÃo   hOjE  " -> ["constelacao", "hoje"]
        let filterWords = text.lowercased()
                            .folding(options: .diacriticInsensitive, locale: .current)
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                            .components(separatedBy: .whitespacesAndNewlines)
        
        // For each section...S
        for sectionIndex in filteredSections.indices.reversed() {
            let articles = filteredSections[sectionIndex].items
            
            // and for each article in a section...
            for articleIndex in articles.indices.reversed() {
                // Get all the words of its title clening with the same logic of the filter
                let articleWords = articles[articleIndex].title
                                    .lowercased()
                                    .folding(options: .diacriticInsensitive, locale: .current)
                                    .trimmingCharacters(in: .whitespacesAndNewlines)
                                    .components(separatedBy: .whitespacesAndNewlines)
                // We assume that has a match
                var hasMatch = true
                
                // So, for each word...
                for word in filterWords {
                    // We search for one word in the article that has it as a prefix
                    // If not, we stop the search and decide that it is not a match
                    // This because we need that all the words typed by the user exists as a prefix
                    // in the article, all of them
                    if !articleWords.contains(where: { $0.hasPrefix(word) }) {
                        hasMatch = false
                        break
                    }
                }
                
                // If it is not a match, we remove the article
                if !hasMatch {
                    filteredSections[sectionIndex].items.remove(at: articleIndex)
                }
            }
            
            // If all the articles were removed, we remove the entire section
            if filteredSections[sectionIndex].items.isEmpty {
                filteredSections.remove(at: sectionIndex)
            }
        }
        
        // At the end, send the result to te table view
        self.hiddenSections.removeAll()
        self.filteredSections = filteredSections
    }
    
    func isSectionHidden(at index: Int) -> Bool {
        return hiddenSections.contains(index)
    }
    
    func toggleSection(at index: Int) {
        if isSectionHidden(at: index) {
            hiddenSections.removeAll { $0 == index }
        } else {
            hiddenSections.append(index)
        }
    }
    
    func goBackToHome() {
        coordinator?.pop()
    }
}
