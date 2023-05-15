//
//  UserDefaultsMovies.swift
//  BAZProject
//
//  Created by ksolano on 01/05/23.
//

import Foundation

/// This extension is used for gice functionality to delete/set and get values from UserDaults
extension UserDefaults: MoviesStorageProtocol {
    /// Delete a key of UserDefaults
    /// - parameters:
    /// - key: is  the key wher we have to delte
    public func delete(forKey key: StorageKey) throws {
        removeObject(forKey: key.rawValue)
    }
    /// Set a key of UserDefaults
    /// - parameters:
    /// - value: Value to set (storage) in this key.
    /// - key: is a enum with the key.
    public func set<T>(_ value: T?, forKey key: StorageKey) throws {
        setValue(value, forKey: key.rawValue)
    }
    /// Get a value in a key of UserDefaults
    /// - parameters:
    /// - key: is a enum with the key
    public func get(forKey key: StorageKey) throws -> Data? {
        return value(forKey:key.rawValue) as? Data
    }
}
