//
//  UIViewController+TitleAnimation.swift
//  EstaparHelpCenter
//
//  Created by Wellington Nascente Hirsch on 21/07/24.
//

import UIKit

extension UIViewController {
    
    func setTitleWithFade(_ title: String?) {
        let animation = CATransition()
        animation.duration = .alpha30
        animation.type = .fade
        
        self.navigationController?.navigationBar.layer.add(animation, forKey: "fadeText")
        self.navigationItem.title = title
    }
}
