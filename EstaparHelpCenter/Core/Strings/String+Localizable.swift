//
//  String+Localizable.swift
//  WellBlog
//
//  Created by Wellington Nascente Hirsch on 21/06/23.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: "Localizable", value: "", comment: "")
    }
    
    func localized(_ args: CVarArg...) -> String {
        return String(
            format: NSLocalizedString(self, tableName: "Localizable", value: "", comment: ""),
            arguments: args
        )
    }
}
