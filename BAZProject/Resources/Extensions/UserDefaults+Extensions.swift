//
//  UserDefaults+Extensions.swift
//  BAZProject
//
//  Created by jmgarciaca on 06/05/23.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
        return UserDefaults(suiteName: "mx.caffeina.bazproject")!
    }
}
