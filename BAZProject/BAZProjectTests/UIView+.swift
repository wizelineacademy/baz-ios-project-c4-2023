//
//  UIView+.swift
//  BAZProject
//
//  Created by Manuel S on 06/05/23.
//

import UIKit

extension UIView {
    
/// Funcion para inicalizar celda y poder realizar Unit Testing
    class func fromNib(named: String? = nil) throws -> Self {
            let name = named ?? "\(Self.self)"
            guard
                let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
                else { throw NSError(domain: "Tests_LoadNib_NoNib", code: -54) }
            guard let view = nib.first as? Self
                else { throw NSError(domain: "Tests_LoadNib_NoView", code: -55) }
            return view
        }
}
