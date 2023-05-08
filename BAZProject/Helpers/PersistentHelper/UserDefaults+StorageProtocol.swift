//
//  UserDefaults+StorageProtocol.swift
//  BAZProject
//
//  Created by 989438 on 08/05/23.
//

import Foundation

extension UserDefaults: StorageProtocol {
    public func set<T>(_ value: T?, forKey key: StorageKey) throws {
        setValue(value, forKey: key.rawValue)
    }
    
    public func get<T>(forKey key: StorageKey) throws -> T? {
        value(forKey: key.rawValue) as? T
    }
    
    public func remove(forKey key: StorageKey) {
        removeObject(forKey: key.rawValue)
    }
}
