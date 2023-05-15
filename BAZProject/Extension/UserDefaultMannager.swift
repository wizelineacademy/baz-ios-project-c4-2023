//
//  UserDefaultMannager.swift
//  BAZProject
//
//  Created by nmorenoa on 05/05/23.
//

import Foundation
///   /// UserDefaultMannager
///
///  This class sets and gets values from UserDefaults
///
final class UserDefaultMannager {
    
    /// set value generic to property specified by a given key
    static func set<T>(value: T, key: UserDefauktKey) {
        let defaults = UserDefaults.standard
        defaults.setValue(value, forKey: key.rawValue)
    }
    
    /// get object generic associated with a key
    static func get<T>(type: T.Type, forKey: UserDefauktKey) -> T? {
       let defaults = UserDefaults.standard
       let value = defaults.object(forKey: forKey.rawValue) as? T
       return value
    }
    
}
