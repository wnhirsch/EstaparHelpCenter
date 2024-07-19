//
//  LoadingView.swift
//  WellBlog
//
//  Created by Wellington Nascente Hirsch on 21/06/23.
//

import UIKit
import SnapKit

class LoadingView: UIView, CodeView {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .estaparPrimary
        activityIndicator.hidesWhenStopped = false
        return activityIndicator
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.textColor = .estaparBlack
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.font = UIFont.estaparMedium(size: .font14)
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
        addSubview(activityIndicator)
        addSubview(messageLabel)
    }
    
    func setupConstraints() {
        activityIndicator.snp.makeConstraints{ (make) -> Void in
            make.center.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints{ (make) -> Void in
            make.top.equalTo(activityIndicator.snp.bottom).inset(CGFloat.size16)
            make.horizontalEdges.equalToSuperview().inset(CGFloat.size16)
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
    
    func setup(message: String?) {
        messageLabel.text = message
    }
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }

    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}
