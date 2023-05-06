//
//  UserDefauktKey.swift
//  BAZProject
//
//  Created by nmorenoa on 05/05/23.
//

import Foundation

extension UserDefauktKey {
    static let favoriteMovies = UserDefauktKey(rawValue: "favorite_movies")
}

public struct UserDefauktKey: RawRepresentable {
    
    public let rawValue: String

    public init(rawValue: String) {
        self.rawValue = rawValue
    }

}
