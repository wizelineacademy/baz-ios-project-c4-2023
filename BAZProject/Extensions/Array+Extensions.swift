//
//  Array+Extensions.swift
//  BAZProject
//
//  Created by Carlos Garcia on 21/04/23.
//

import Foundation

extension Array {
    /**
     Return elemento of array only if exist.
     */
    subscript (safe index: Int) -> Element? {
        return (index < count && index >= 0) ? self[index] : nil
    }
}
