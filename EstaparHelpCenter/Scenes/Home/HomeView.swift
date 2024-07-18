//
//  HomeView.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import Combine
import SnapKit
import UIKit

class HomeView: UIView, CodeView {
    
    private let helpCenterButton: UIButton = {
        var filled = UIButton.Configuration.filled()
        filled.cornerStyle = .fixed
        filled.background.cornerRadius = .size10
        filled.baseBackgroundColor = .estaparPrimary
        filled.baseForegroundColor = .estaparWhite
        filled.contentInsets = .init(top: .size10, leading: .size10, bottom: .size10, trailing: .size10)
        
        var container = AttributeContainer()
        container.font = .estaparMedium(size: .font14)
        filled.attributedTitle = AttributedString("Abrir Central de Ajuda", attributes: container)
        
        return UIButton(configuration: filled)
    }()
    
    
    let helpCenterPublisher = PassthroughSubject<Void, Never>()
    
    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        addSubview(helpCenterButton)
    }
    
    func setupConstraints() {
        helpCenterButton.snp.makeConstraints { (make) -> Void in
            make.center.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .estaparWhite
        helpCenterButton.addTarget(self, action: #selector(didTapHelpCenterButton), for: .touchUpInside)
    }

    @objc private func didTapHelpCenterButton() {
        helpCenterPublisher.send()
    }
}
