//
//  UserDefaultsMovies.swift
//  BAZProject
//
//  Created by ksolano on 01/05/23.
//

import Foundation

extension UserDefaults: MoviesStorageProtocol {
    public func delete(forKey key: StorageKey) throws {
        removeObject(forKey: key.rawValue)
    }
    
    public func set<T>(_ value: T?, forKey key: StorageKey) throws {
        print("pasamos aquí")
        setValue(value, forKey: key.rawValue)
    }
    
    public func get(forKey key: StorageKey) throws -> Data? {
        print("obtenemos datos")
        return value(forKey:key.rawValue) as? Data
    }
}
