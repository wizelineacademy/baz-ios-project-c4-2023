//
//  ReusableIdentifier.swift
//  BAZProject
//
//  Created by 989438 on 30/03/23.
//

import Foundation

protocol ReusableIdentifier {
    static var reusableIdentifier: String { get }
}

extension ReusableIdentifier {
    static var reusableIdentifier: String { String(describing: self) }
}
