//
//  HelpCenterCategoryCell.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 21/07/24.
//

import SnapKit
import UIKit

class HelpCenterCategoryCell: UITableViewCell, CodeView {
    
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
        label.font = .estaparMedium(size: .font14)
        label.textColor = .estaparBlack
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .arrowRight
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(arrowImageView)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(CGFloat.size15)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(CGFloat.size16)
            make.width.equalTo(CGFloat.size16)
        }
    }
    
    func setupAdditionalConfiguration() {
        selectionStyle = .none
    }
    
    func setup(model: HelpCenterCategoryModel.Section.Article) {
        titleLabel.text = model.title
    }
}
