//
//  FontPattern.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import UIKit

extension CGFloat {
    
    /// font-size = 14
    static var font14: CGFloat = 14
    /// font-size = 16
    static var font16: CGFloat = 16
    /// font-size = 24
    static var font24: CGFloat = 24
}

extension UIFont {
    
    static func estaparMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "Inter-Medium", size: size) ?? .systemFont(ofSize: size, weight: .medium)
    }
    
    static func estaparSemiBold(size: CGFloat) -> UIFont {
        return UIFont(name: "SemiBold", size: size) ?? .systemFont(ofSize: size, weight: .semibold)
    }
    
    static func estaparBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Bold", size: size) ?? .systemFont(ofSize: size, weight: .bold)
    }
}
