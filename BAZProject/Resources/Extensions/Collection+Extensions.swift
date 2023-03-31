//
//  Collection+Extensions.swift
//  BAZProject
//
//  Created by jmgarciaca on 31/03/23.
//

import Foundation

/*
 The following code is an extension to any type that conforms to the Collection protocol in Swift. Provides a safe way to access a subscript collection element with an index.
 */
extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
