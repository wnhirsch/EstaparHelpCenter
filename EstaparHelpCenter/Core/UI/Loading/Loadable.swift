//
//  Loadable.swift
//  WellBlog
//
//  Created by Wellington Nascente Hirsch on 21/06/23.
//

import UIKit

protocol Loadable {
    func showLoading(message: String?, on subview: UIView?)
    func hideLoading()
}

extension Loadable where Self: UIViewController {

    private func findLoadingView() -> LoadingView? {
        return view.subviews.compactMap { $0 as? LoadingView }.first
    }

    private func addLoadingView(subview: UIView? = nil) -> LoadingView {
        let loadingView = LoadingView()
        loadingView.startAnimating()
        
        if let superview = subview ?? view {
            superview.addSubview(loadingView)
            loadingView.snp.makeConstraints{ (make) -> Void in
                make.center.equalToSuperview()
            }
        }

        return loadingView
    }

    func showLoading(message: String? = nil, on subview: UIView? = nil) {
        view.endEditing(true)
        
        if let loadingView = findLoadingView() {
            loadingView.setup(message: message)
            view.bringSubviewToFront(loadingView)
            return
        }

        let loadingView = addLoadingView(subview: subview)
        loadingView.setup(message: message)
        loadingView.alpha = 1
    }

    func hideLoading() {
        guard let loadingView = findLoadingView() else {
            return
        }

        UIView.animate(withDuration: .alpha25, animations: {
            loadingView.alpha = .zero
        }, completion: { _ in
            loadingView.stopAnimating()
            loadingView.removeFromSuperview()
        })
    }
    
}
