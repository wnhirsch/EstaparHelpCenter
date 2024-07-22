//
//  HelpCenterCategoryView.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 19/07/24.
//

import SnapKit
import UIKit

class HelpCenterCategoryView: UIView, CodeView {
    
    private lazy var roundedView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = .size20
        view.backgroundColor = .estaparWhite
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.estaparBold(size: .font16)
        label.textColor = .estaparBlack
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "helpcenter.category.title".localized
        return label
    }()
    
    lazy var searchField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .asciiCapable
        textField.returnKeyType = .search
        textField.font = .estaparSemiBold(size: .font14)
        textField.attributedPlaceholder = .init(
            string: "helpcenter.category.search".localized,
            attributes: [
                .foregroundColor: UIColor.estaparPrimaryGray,
                .font: UIFont.estaparSemiBold(size: .font14)
            ]
        )
        
        textField.textColor = .estaparBlack
        textField.tintColor = .estaparPrimary
        textField.backgroundColor = .estaparSecondaryGray
        
        textField.layer.borderColor = UIColor.clear.cgColor
        textField.layer.borderWidth = .size2
        textField.layer.cornerRadius = .size10
        
        let searchImage = UIImageView(
            frame: CGRect(x: .size15, y: .size15, width: .size20, height: .size20)
        )
        searchImage.image = .search
        searchImage.contentMode = .scaleAspectFit
        
        let leftView = UIView( // Trick to better positionate the search icon
            frame: CGRect(x: .zero, y: .zero, width: .size15 + .size20 + .size10, height: .size50)
        )
        leftView.addSubview(searchImage)
        
        textField.leftView = leftView
        textField.leftViewMode = .always
        return textField
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(HelpCenterCategoryCell.self)
        tableView.backgroundColor = .estaparWhite
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = .size50
        tableView.separatorStyle = .none
        tableView.contentInset = .init(
            top: .size15 + .size10, // Trick to see the cards passing behind the search field
            left: .zero,
            bottom: .size15,
            right: .zero
        )
        return tableView
    }()
    
    private lazy var emptyListLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.estaparMedium(size: .font14)
        label.textColor = .estaparPrimaryGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = "helpcenter.category.empty".localized
        label.alpha = 0
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(roundedView)
        
        roundedView.addSubview(titleLabel)
        roundedView.addSubview(tableView)
        roundedView.addSubview(searchField)
        roundedView.addSubview(emptyListLabel)
    }
    
    func setupConstraints() {
        roundedView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().offset(CGFloat.size20)
        }
        
        titleLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().inset(CGFloat.size20)
            make.horizontalEdges.equalToSuperview().inset(CGFloat.size20)
        }
        
        searchField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleLabel.snp.bottom).offset(CGFloat.size10)
            make.horizontalEdges.equalToSuperview().inset(CGFloat.size20)
            make.height.equalTo(CGFloat.size50)
        }
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(searchField.snp.bottom).inset(CGFloat.size10)
            make.horizontalEdges.equalToSuperview().inset(CGFloat.size20)
            make.bottom.equalToSuperview()
        }
        
        emptyListLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(searchField.snp.bottom).offset(CGFloat.size20)
            make.horizontalEdges.equalToSuperview().inset(CGFloat.size20)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .estaparPrimary
    }
    
    func animateTransition(isAppearing: Bool, completion: (() -> Void)? = nil) {
        if isAppearing {
            titleLabel.alpha = 0
            searchField.alpha = 0
            tableView.alpha = 0
            
            UIView.animate(withDuration: .alpha30, delay: .zero, options: .curveEaseOut) {
                self.titleLabel.alpha = 1
                self.searchField.alpha = 1
                self.tableView.alpha = 1
            } completion: { _ in completion?() }
        } else {
            UIView.animate(withDuration: .alpha30, delay: .zero, options: .curveEaseOut) {
                self.titleLabel.alpha = 0
                self.searchField.alpha = 0
                self.tableView.alpha = 0
                self.emptyListLabel.alpha = 0
            } completion: { _ in completion?() }
        }
    }
    
    func animateSearchFieldBorder(isFocused: Bool) {
        if isFocused {
            UIView.animate(withDuration: .alpha30, delay: .zero, options: .curveEaseOut) {
                self.searchField.layer.borderColor = UIColor.estaparPrimary.cgColor
            }
        } else {
            UIView.animate(withDuration: .alpha30, delay: .zero, options: .curveEaseOut) {
                self.searchField.layer.borderColor = UIColor.clear.cgColor
            }
        }
    }
    
    func showEmptyListMessage(shouldAppear: Bool) {
        if shouldAppear {
            UIView.animate(withDuration: .alpha30, delay: .zero, options: .curveEaseOut) {
                self.emptyListLabel.alpha = 1
            }
        } else {
            UIView.animate(withDuration: .alpha30, delay: .zero, options: .curveEaseOut) {
                self.emptyListLabel.alpha = 0
            }
        }
    }
}
