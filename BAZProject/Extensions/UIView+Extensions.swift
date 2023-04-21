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
                                                owner  : owner,
                                                options: nil)?[0] as? UIView
        instance?.autoresizingMask = [.flexibleWidth,
                                     .flexibleHeight]
        if let owner = owner {
            instance?.frame = owner.bounds
            owner.addSubview(instance ?? UIView())
        }
        return instance ?? UIView()
    }
}
