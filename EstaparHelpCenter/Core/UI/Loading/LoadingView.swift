//
//  LoadingView.swift
//  WellBlog
//
//  Created by Wellington Nascente Hirsch on 21/06/23.
//

import UIKit
import SnapKit

class LoadingView: UIView, CodeView {
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .label
        activityIndicator.hidesWhenStopped = false
        return activityIndicator
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = nil
        label.textColor = .label
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: .font16)
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
            make.trailing.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.top.equalTo(activityIndicator.snp.bottom).offset(16)
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
