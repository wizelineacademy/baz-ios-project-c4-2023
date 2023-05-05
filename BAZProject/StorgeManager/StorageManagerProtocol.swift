//
//  StorageManagerProtocol.swift
//  BAZProject
//
//  Created by Carlos Garcia on 04/05/23.
//

import Foundation

public protocol StorageManagerProtocol {
    /// Store any value for a specific key overriding previous value if exists
    func set<T>(_ value: T?, forKey key: StorageKey)
    /// Retrieves any value for a specific key or nil if none exists
    func get<T>(forKey key: StorageKey) -> T?
    /// Store any value for a specific key throwing duplicate error if previous value exists
    func add<T>(_ value: T?, forKey key: StorageKey)
    /// Removes (sets to nil) any value for a specific key
    func remove(forKey key: StorageKey)
    /// Store a Encodable value for a specific key overriding previous value if exists
    func store<T: Encodable>(_ value: T?, forKey key: StorageKey, usingEncoder encoder: JSONEncoder)
    /// Retrieves a Decodable value for a specific key or nil if none exists
    func retrieve<T: Decodable>(forKey key: StorageKey, usingDecoder decoder: JSONDecoder) -> T?
    /// Purges all data in storage
    func purge()
}

public extension StorageManagerProtocol {
    /// Store a Encodable value for a specific key overriding previous value if exists
    func store<T: Encodable>(_ value: T?, forKey key: StorageKey) {
        self.store(value, forKey: key, usingEncoder: .init())
    }
    /// Retrieves a Decodable value for a specific key or nil if none exists
    func retrieve<T: Decodable>(forKey key: StorageKey) -> T? {
        self.retrieve(forKey: key, usingDecoder: .init())
    }
}
