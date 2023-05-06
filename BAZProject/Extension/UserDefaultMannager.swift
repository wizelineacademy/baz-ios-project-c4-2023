//
//  UserDefaultMannager.swift
//  BAZProject
//
//  Created by nmorenoa on 05/05/23.
//

import Foundation

final class UserDefaultMannager {
    
    static func set<T>(value: T, key: UserDefauktKey) {
        let defaults = UserDefaults.standard
        defaults.setValue(value, forKey: key.rawValue)
    }
    
    static func get<T>(type: T.Type, forKey: UserDefauktKey) -> T? {
       let defaults = UserDefaults.standard
       let value = defaults.object(forKey: forKey.rawValue) as? T
       return value
    }
    
}
