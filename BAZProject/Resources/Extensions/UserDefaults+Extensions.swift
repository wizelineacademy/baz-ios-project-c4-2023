//
//  UserDefaults+Extensions.swift
//  BAZProject
//
//  Created by jmgarciaca on 06/05/23.
//

import Foundation

/// A shared instance of `UserDefaults` with a specific suite name.
/// - Returns: A `UserDefaults` instance with the suite name "mx.caffeina.bazproject".
extension UserDefaults {
    static var shared: UserDefaults? {
        return UserDefaults(suiteName: "mx.caffeina.bazproject")
    }
}
