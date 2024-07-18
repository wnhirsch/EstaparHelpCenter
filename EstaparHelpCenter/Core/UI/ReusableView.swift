//
//  ReusableView.swift
//  WellBlog
//
//  Created by Wellington Nascente Hirsch on 21/06/23.
//

import UIKit

public protocol ReusableView: AnyObject {
    static var identifier: String { get }
}

public extension ReusableView where Self: UIView {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}
