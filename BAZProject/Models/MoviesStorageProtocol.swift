//
//  MoviesStorageProtocol.swift
//  BAZProject
//
//  Created by ksolano on 01/05/23.
//

import Foundation

public protocol MoviesStorageProtocol {
    func set<T>(_ value: T?, forKey key: StorageKey) throws
    func get(forKey key: StorageKey) throws -> Data?
    func delete(forKey key: StorageKey) throws
}
