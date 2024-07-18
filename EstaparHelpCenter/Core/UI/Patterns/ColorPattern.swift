//
//  ColorPattern.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import UIKit

extension UIColor {
    
    /// color = #003FE1
    static var estaparPrimary = UIColor(hex: "#003FE1")
    /// color = #B0C5FB
    static var estaparSecondary = UIColor(hex: "#B0C5FB")
    /// color = #121212
    static var estaparBlack = UIColor(hex: "#121212")
    /// color = #FFFFFF
    static var estaparWhite = UIColor(hex: "#FFFFFF")
    /// color = #9CA3AF
    static var estaparPrimaryGray = UIColor(hex: "#9CA3AF")
    /// color = #F3F4F6
    static var estaparSecondaryGray = UIColor(hex: "#F3F4F6")
    
    // MARK: Hexadecimal
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            alpha: Double(a) / 255
        )
    }
}
