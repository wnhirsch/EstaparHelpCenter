//
//  HelpCenterHomeViewController.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import Combine
import UIKit

class HelpCenterHomeViewController: UIViewController, Loadable {

    private let contentView: HelpCenterHomeView
    private let viewModel: HelpCenterHomeViewModel
    
    private var isOnBackground = false
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: HelpCenterHomeViewModel) {
        contentView = HelpCenterHomeView()
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
        if isOnBackground {
            setTitleWithFade("helpcenter.home.title".localized)
            
            contentView.animateTransition(isAppearing: true) { [weak self] in
                guard let self = self else { return }
                self.isOnBackground = false
            }
        }
    }
    
    private func setupNavigationBar() {
        setTitleWithFade("helpcenter.home.title".localized)
        
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
    }
    
    private func bind() {
        contentView.collectionView.dataSource = self
        contentView.collectionView.delegate = self
        
        // Loading event
        viewModel.$isLoading.sink { [weak self] isLoading in
            guard let self = self else { return }
            isLoading ? self.showLoading() : self.hideLoading()
        }.store(in: &cancellables)
        
        // Update Header Image event
        viewModel.$imageURL
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self, let imageURL = self.viewModel.imageURL else { return }
                self.contentView.setupHeaderImage(url: imageURL)
        }.store(in: &cancellables)
        
        // Update Line 1 event
        viewModel.$line1
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.contentView.setupLine1Label(text: viewModel.line1)
        }.store(in: &cancellables)
        
        // Update Line 2 event
        viewModel.$line2
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.contentView.setupLine2Label(text: viewModel.line2)
        }.store(in: &cancellables)
        
        // Load Categories event
        viewModel.$categories
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.contentView.collectionView.reloadData()
        }.store(in: &cancellables)
        
        // First API call
        viewModel.fetchCategories()
    }
}

extension HelpCenterHomeViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return viewModel.categories.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            HelpCenterHomeCategoryCell.self,
            for: indexPath
        )
        cell.setup(model: viewModel.categories[indexPath.row])
        return cell
    }
}

extension HelpCenterHomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setTitleWithFade(nil) // Hide navigation title
        
        contentView.animateTransition(isAppearing: isOnBackground) { [weak self] in
            guard let self = self else { return }
            self.isOnBackground = true
            self.viewModel.goToCategory(index: indexPath.row)
        }
    }
}

extension HelpCenterHomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        // width = half the Collection View width minus the margin, creating 2 columns
        return CGSize(width: (collectionView.frame.width - .size15) / 2, height: .size120)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return .init(top: .size20, left: .zero, bottom: .size20, right: .zero)
    }
}

extension HelpCenterHomeViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Guarantees that the scroll offset can be -100
        scrollView.contentInset.top = .size100
        // Update the header size and compute a new offset based on it
        scrollView.contentOffset.y = contentView.updateHeaderScroll(
            offset: scrollView.contentOffset.y
        )
    }
}
