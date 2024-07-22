//
//  HelpCenterCategoryHeader.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 21/07/24.
//

import Combine
import SnapKit
import UIKit

class HelpCenterCategoryHeader: UIView, CodeView {
    
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
        view.alpha = 0
        view.isHidden = true
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(stackView)
        
        stackView.addArrangedSubview(titleStackView)
        stackView.addArrangedSubview(dividerView)
        
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(arrowImageView)
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
        
        dividerView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(CGFloat.size2)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .estaparWhite
    }
    
    func setup(index: Int, model: HelpCenterCategoryModel.Section, isExpanded: Bool) {
        tag = index
        titleLabel.text = model.title
        
        if isExpanded {
            arrowImageView.transform = .init(rotationAngle: -.pi/2)
            dividerView.alpha = 1
            dividerView.isHidden = false
        } else {
            arrowImageView.transform = .init(rotationAngle: .pi/2)
            dividerView.alpha = 0
            dividerView.isHidden = true
        }
    }
    
    func setupBorder() {
        let lineWidth: CGFloat = .size2
        let radius: CGFloat = .size10
        let maxX = frame.width - lineWidth
        let maxY = frame.height - lineWidth / 2
        
        let path = UIBezierPath()
        path.move(to: .init(x: .zero, y: maxY))
        path.addLine(to: .init(x: .zero, y: radius))
        path.addArc(
            withCenter: .init(x: .size10, y: radius),
            radius: radius,
            startAngle: .pi,
            endAngle: -.pi/2,
            clockwise: true
        )
        path.addLine(to: .init(x: maxX - radius, y: .zero))
        path.addArc(
            withCenter: .init(x: maxX - radius, y: radius),
            radius: radius,
            startAngle: -.pi/2,
            endAngle: .zero,
            clockwise: true
        )
        path.addLine(to: .init(x: maxX, y: maxY))
        
        let shape = CAShapeLayer()
        shape.position = .init(x: lineWidth / 2, y: lineWidth / 2)
        shape.strokeColor = UIColor.estaparSecondaryGray.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineWidth = lineWidth
        shape.path = path.cgPath
        layer.addSublayer(shape)
    }
}
