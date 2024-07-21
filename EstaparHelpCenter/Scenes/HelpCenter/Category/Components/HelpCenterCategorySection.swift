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
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = .size15
        return stackView
    }()
    
    private lazy var titleStackView: UIStackView = {
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
        view.alpha = isShowingArticles ? 1 : 0
        view.isHidden = !isShowingArticles
        return view
    }()
    
    lazy var tableView: DynamicTableView = {
        let tableView = DynamicTableView()
        tableView.register(HelpCenterCategoryCell.self)
        tableView.backgroundColor = .estaparWhite
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.clipsToBounds = false
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.alpha = isShowingArticles ? 1 : 0
        tableView.isHidden = !isShowingArticles
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.autoresizingMask = .flexibleHeight
    }
    
    func buildViewHierarchy() {
        contentView.addSubview(cardView)
        
        cardView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleStackView)
        stackView.addArrangedSubview(dividerView)
        stackView.addArrangedSubview(tableView)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(arrowImageView)
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
            make.bottom.equalToSuperview().inset(CGFloat.size15)
        }
        stackView.setCustomSpacing(.zero, after: dividerView)
        
        arrowImageView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(CGFloat.size16)
            make.width.equalTo(CGFloat.size16)
        }
        
        dividerView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(CGFloat.size2)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .estaparWhite
        selectionStyle = .none
        tableView.dataSource = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeVisibility))
        tapGesture.cancelsTouchesInView = false
        titleStackView.isUserInteractionEnabled = true
        titleStackView.addGestureRecognizer(tapGesture)
    }
    
    func setup(model: HelpCenterCategoryModel.Section, isFiltering: Bool) {
        titleLabel.text = model.title
        articles = model.items
        tableView.reloadData()
        
        if isFiltering && !isShowingArticles {
            changeVisibility()
        }
    }
    
    @objc func changeVisibility() {
        if isShowingArticles {
            UIView.animate(withDuration: .alpha30, delay: .zero, options: .curveEaseOut) {
                self.arrowImageView.transform = .init(rotationAngle: -.pi/2)
                self.dividerView.alpha = 0
                self.dividerView.isHidden = true
                self.tableView.alpha = 0
                self.tableView.isHidden = true
            }
        } else {
            UIView.animate(withDuration: .alpha30, delay: .zero, options: .curveEaseOut) {
                self.arrowImageView.transform = .init(rotationAngle: .pi/2)
                self.dividerView.alpha = 1
                self.dividerView.isHidden = false
                self.tableView.alpha = 1
                self.tableView.isHidden = false
            }
        }
        isShowingArticles.toggle()
    }
}

// MARK: - UITableViewDataSource
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
