//
//  Util.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 05/05/23.
//

import UIKit

extension UIView {
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
