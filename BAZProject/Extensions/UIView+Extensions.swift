//
//  UIView+Extensions.swift
//  BAZProject
//
//  Created by Carlos Garcia on 19/04/23.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult class func initXIB<Type: UIView>(owner: Type?) -> UIView {
        let instance = Bundle.main.loadNibNamed(String(describing: self),
                                                owner: owner,
                                                options: nil)?[0] as? UIView
        instance?.autoresizingMask = [.flexibleWidth,
                                     .flexibleHeight]
        if let owner = owner {
            instance?.frame = owner.bounds
            owner.addSubview(instance ?? UIView())
        }
        return instance ?? UIView()
    }
    
    /**
     Add and configure a subivew without autoresizing behavior.
     */
    func addSubviewForAutolayout(_ subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
    }
    
    /**
     Show an activity indicator at center of the view.
     */
    func showActivityIndicator() {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.tag = 888
        addSubviewForAutolayout(loader)
        NSLayoutConstraint.activate([
            loader.topAnchor.constraint(equalTo: self.topAnchor),
            loader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            loader.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            loader.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        loader.startAnimating()
    }
    
    /**
     Remove the activity indicator if view contains it.
     */
    func hideActivityIndicator() {
        if let subview = self.subviews.first(where: { $0.tag == 888 }) {
            subview.removeFromSuperview()
        }
    }
}
