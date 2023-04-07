//
//  ReusableCell.swift
//  BAZProject
//
//  Created by Carlos Garcia on 07/04/23.
//

import Foundation

protocol ReusableCell {
    static var reusableIdentifier: String { get }
}

extension ReusableCell {
    static var reusableIdentifier: String { String(describing: self) }
}
