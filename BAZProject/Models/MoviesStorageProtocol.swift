//
//  MoviesStorageProtocol.swift
//  BAZProject
//
//  Created by ksolano on 01/05/23.
//

import Foundation

/// Protocol to give us defined funcs for use with UserDefaults 
public protocol MoviesStorageProtocol {
    func set<T>(_ value: T?, forKey key: StorageKey) throws
    func get(forKey key: StorageKey) throws -> Data?
    func delete(forKey key: StorageKey) throws
}
