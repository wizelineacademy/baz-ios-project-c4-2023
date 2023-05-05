//
//  StorageKey.swift
//  BAZProject
//
//  Created by Carlos Garcia on 04/05/23.
//

import Foundation

public struct StorageKey: RawRepresentable {
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }
}

extension StorageKey {
    static let favoriteMovies = StorageKey(rawValue: "kFavoriteMovies")
    static let user = StorageKey(rawValue: "kUser")
}
