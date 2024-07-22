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
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(arrowImageView)
    }
    
    func setupConstraints() {
        stackView.snp.makeConstraints { (make) -> Void in
            make.top.equalToSuperview().offset(CGFloat.size15)
            make.horizontalEdges.equalToSuperview().inset(CGFloat.size15)
            make.bottom.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(CGFloat.size16)
            make.width.equalTo(CGFloat.size16)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .estaparWhite
        selectionStyle = .none
    }
    
    func setup(model: HelpCenterCategoryModel.Section.Article) {
        titleLabel.text = model.title
    }
    
    func setupBorder() {
        let lineWidth: CGFloat = .size2
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: .init(x: .zero, y: frame.height))
        
        let leftShape = CAShapeLayer()
        leftShape.position = .init(x: lineWidth / 2, y: .zero)
        leftShape.strokeColor = UIColor.estaparSecondaryGray.cgColor
        leftShape.lineWidth = lineWidth
        leftShape.path = path.cgPath
        layer.addSublayer(leftShape)
        
        let rightShape = CAShapeLayer()
        rightShape.position = .init(x: frame.width - lineWidth / 2, y: .zero)
        rightShape.strokeColor = UIColor.estaparSecondaryGray.cgColor
        rightShape.lineWidth = lineWidth
        rightShape.path = path.cgPath
        layer.addSublayer(rightShape)
    }
}
