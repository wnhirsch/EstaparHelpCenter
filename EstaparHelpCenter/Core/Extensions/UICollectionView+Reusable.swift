//
//  UICollectionView+Reusable.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 18/07/24.
//

import UIKit

extension UICollectionView {
    
    func register(_ cell: UICollectionViewCell.Type) {
        self.register(cell.self, forCellWithReuseIdentifier: cell.identifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(
        _ type: T.Type,
        for indexPath: IndexPath
    ) -> T {
        if let cell = dequeueReusableCell(
            withReuseIdentifier: type.identifier,
            for: indexPath
        ) as? T {
            return cell
        } else {
            return T()
        }
    }
}
