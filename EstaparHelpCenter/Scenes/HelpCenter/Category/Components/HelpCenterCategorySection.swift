//
//  HelpCenterCategorySection.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 21/07/24.
//

import Combine
import SnapKit
import UIKit

class HelpCenterCategorySection: UITableViewCell, CodeView {
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.estaparSecondaryGray.cgColor
        view.layer.borderWidth = .size2
        view.layer.cornerRadius = .size10
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = .size15
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .estaparSemiBold(size: .font14)
        label.textColor = .estaparPrimary
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .arrowRight
        imageView.transform = .init(rotationAngle: .pi/2)
        return imageView
    }()
    
    private lazy var dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .estaparSecondaryGray
        return view
    }()
    
    lazy var tableView: DynamicTableView = {
        let tableView = DynamicTableView()
        tableView.register(HelpCenterCategoryCell.self)
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.clipsToBounds = false
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        return tableView
    }()
    
    private var isShowingArticles = false
    private var articles = [HelpCenterCategoryModel.Section.Article]()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(cardView)
        
        cardView.addSubview(stackView)
        cardView.addSubview(dividerView)
        cardView.addSubview(tableView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(arrowImageView)
    }
    
    func setupConstraints() {
        cardView.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview().inset(CGFloat.size15)
        }
        
        stackView.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(CGFloat.size15)
            make.horizontalEdges.equalToSuperview().inset(CGFloat.size15)
        }
        
        arrowImageView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(CGFloat.size16)
            make.width.equalTo(CGFloat.size16)
        }
        
        dividerView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(stackView.snp.bottom).offset(CGFloat.size15)
            make.horizontalEdges.equalToSuperview().inset(CGFloat.size15)
            make.height.equalTo(CGFloat.size2)
        }
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(dividerView.snp.bottom)
            make.horizontalEdges.equalToSuperview().inset(CGFloat.size15)
            make.bottom.equalToSuperview().inset(CGFloat.size15)
        }
    }
    
    func setupAdditionalConfiguration() {
        selectionStyle = .none
        tableView.dataSource = self
        
        // TODO: Not working
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeVisibility))
        cardView.isUserInteractionEnabled = true
        cardView.addGestureRecognizer(tapGesture)
    }
    
    func setup(model: HelpCenterCategoryModel.Section) {
        titleLabel.text = model.title
        articles = model.items
        tableView.reloadData()
    }
    
    @objc func changeVisibility() {
        if isShowingArticles {
            UIView.animate(withDuration: .alpha30, delay: .zero, options: .curveEaseOut) {
                self.arrowImageView.transform = .init(rotationAngle: -.pi/2)
            }
        } else {
            UIView.animate(withDuration: .alpha30, delay: .zero, options: .curveEaseOut) {
                self.arrowImageView.transform = .init(rotationAngle: .pi/2)
            }
        }
        isShowingArticles.toggle()
    }
}

extension HelpCenterCategorySection: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(HelpCenterCategoryCell.self, for: indexPath)
        cell.setup(model: articles[indexPath.row])
        return cell
    }
}
