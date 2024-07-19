//
//  HelpCenterHomeCategoryCell.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import Combine
import SnapKit
import UIKit

class HelpCenterHomeCategoryCell: UICollectionViewCell, CodeView {
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.estaparSecondaryGray.cgColor
        view.layer.borderWidth = .size2
        view.layer.cornerRadius = .size10
        return view
    }()
    
    private lazy var cardStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.estaparBold(size: .font14)
        label.textColor = .estaparBlack
        label.textAlignment = .left
        label.numberOfLines = .zero
        return label
    }()
    
    private lazy var footerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private lazy var articlesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.estaparMedium(size: .font14)
        label.textColor = .estaparPrimaryGray
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = .arrowRight
        return imageView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(cardView)
        
        cardView.addSubview(cardStackView)
        
        cardStackView.addArrangedSubview(titleLabel)
        cardStackView.addArrangedSubview(footerStackView)
        
        footerStackView.addArrangedSubview(articlesLabel)
        footerStackView.addArrangedSubview(arrowImageView)
    }
    
    func setupConstraints() {
        cardView.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        cardStackView.snp.makeConstraints { (make) -> Void in
            make.edges.equalToSuperview().inset(CGFloat.size15)
        }
        
        arrowImageView.snp.makeConstraints { (make) -> Void in
            make.size.equalTo(CGFloat.size16)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .estaparWhite
    }
    
    func setup(model: HelpCenterHomeModel.Category) {
        titleLabel.text = model.title
        articlesLabel.text = "helpcenter.home.articles".localized(model.totalArticles)
    }
}
