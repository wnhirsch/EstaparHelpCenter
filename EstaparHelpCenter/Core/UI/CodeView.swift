//
//  CodeView.swift
//  WellBlog
//
//  Created by Wellington Nascente Hirsch on 21/06/23.
//

public protocol CodeView {

    func buildViewHierarchy()
    func setupConstraints()
    func setupAdditionalConfiguration()
    func setupView()

}

public extension CodeView {

    func setupView() {
        buildViewHierarchy()
        setupConstraints()
        setupAdditionalConfiguration()
    }

}
