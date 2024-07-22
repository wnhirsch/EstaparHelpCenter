//
//  UITableView+Reusable.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 21/07/24.
//

import UIKit

extension UITableView {
    
    func register(_ cell: UITableViewCell.Type) {
        self.register(cell.self, forCellReuseIdentifier: cell.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, for indexPath: IndexPath) -> T {
        if let cell = dequeueReusableCell(withIdentifier: type.identifier, for: indexPath) as? T {
            return cell
        } else {
            return T()
        }
    }
}
