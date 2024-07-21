//
//  DynamicTableView.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 21/07/24.
//

import UIKit

class DynamicTableView: UITableView {
    override var contentSize: CGSize {
        didSet {
            self.invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        self.layoutIfNeeded()
        return CGSize(width: UIView.noIntrinsicMetric, height: contentSize.height)
    }
}
