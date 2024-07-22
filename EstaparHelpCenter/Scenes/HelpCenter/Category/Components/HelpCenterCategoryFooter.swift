//
//  HelpCenterCategoryFooter.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 21/07/24.
//

import Combine
import SnapKit
import UIKit

class HelpCenterCategoryFooter: UIView, CodeView {
    
    init() {
        super.init(frame: .zero)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() { }
    
    func setupConstraints() { }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .estaparWhite
    }
    
    func setupBorder() {
        let lineWidth: CGFloat = .size2
        let radius: CGFloat = .size10
        let maxX = frame.width - lineWidth
        let maxY = CGFloat.size15 - lineWidth / 2
        
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: .init(x: .zero, y: maxY - radius))
        path.addArc(
            withCenter: .init(x: .size10, y: maxY - radius),
            radius: radius,
            startAngle: .pi,
            endAngle: .pi/2,
            clockwise: false
        )
        path.addLine(to: .init(x: maxX - radius, y: maxY))
        path.addArc(
            withCenter: .init(x: maxX - radius, y: maxY - radius),
            radius: radius,
            startAngle: .pi/2,
            endAngle: .zero,
            clockwise: false
        )
        path.addLine(to: .init(x: maxX, y: .zero))
        
        let shape = CAShapeLayer()
        shape.position = .init(x: lineWidth / 2, y: lineWidth / 2)
        shape.strokeColor = UIColor.estaparSecondaryGray.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.lineWidth = lineWidth
        shape.path = path.cgPath
        layer.addSublayer(shape)
    }
}
