//
//  StorageKey.swift
//  BAZProject
//
//  Created by ksolano on 01/05/23.
//

import Foundation

public struct StorageKey: RawRepresentable {
    
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

}

extension StorageKey {
    static let moviesFavourites = StorageKey(rawValue: "moviesFavourites")
}
