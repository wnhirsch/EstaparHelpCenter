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
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .estaparPrimary
    }
    
    func animateTransition(isAppearing: Bool, completion: (() -> Void)? = nil) {
        if isAppearing {
            self.titleLabel.alpha = 0
            
            UIView.animate(withDuration: .alpha30, delay: .zero, options: .curveEaseOut) {
                self.titleLabel.alpha = 1
            } completion: { _ in completion?() }
        } else {
            UIView.animate(withDuration: .alpha30, delay: .zero, options: .curveEaseOut) {
                self.titleLabel.alpha = 0
            } completion: { _ in completion?() }
        }
    }
}
