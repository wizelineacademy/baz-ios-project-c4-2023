//
//  Array.swift
//  BAZProject
//
//  Created by gescarcega on 06/05/23.
//

import Foundation

public extension Array {
    
    func trim(max size: Int) -> Array {
        var new = self
        let amountToTrim = self.count - size
        if amountToTrim > 0 {
            new = self.dropLast(amountToTrim)
        }
        return new
    }
    
}
