//
//  Array+Extensions.swift
//  BAZProject
//
//  Created by Carlos Garcia on 21/04/23.
//

import Foundation

extension Array {
    subscript (safe index: Int) -> Element? {
        return (index < count && index >= 0) ? self[index] : nil
    }
}
