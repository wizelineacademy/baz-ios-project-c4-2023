//
//  FileManager.swift
//  BAZProject
//
//  Created by Carlos Garcia on 04/05/23.
//

import Foundation

extension FileManager {

    enum Error: Swift.Error {
        case pathNotFound
        case unsupportedType
        case duplicateEntry
        case unknown
    }

    private func path(
        for searchPathDirectory: FileManager.SearchPathDirectory = .documentDirectory,
        in domainMask: FileManager.SearchPathDomainMask = .userDomainMask
    ) throws -> URL {
        guard let path = urls(for: searchPathDirectory, in: domainMask).first else {
            throw Error.pathNotFound
        }
        return path
    }

    func save(data: Data, in filename: String) throws {
        let urlPath = try path().appendingPathComponent(filename)
        try data.write(to: urlPath)
    }

    func load(from filename: String) throws -> Data {
        let urlPath = try path().appendingPathComponent(filename)
        return try Data(contentsOf: urlPath)
    }

    func delete(filename: String) throws {
        let urlPath = try path().appendingPathComponent(filename)
        try removeItem(at: urlPath)
    }

    func deleteAll() throws {
        let urlPath = try path()
        guard urlPath.hasDirectoryPath else { return }
        try contentsOfDirectory(at: urlPath, includingPropertiesForKeys: nil).forEach {
            try removeItem(at: $0)
        }
    }
}

extension FileManager: StorageProtocol {

    public func set<T>(_ value: T?, forKey key: StorageKey) throws {
        guard let value = value else {
            return try remove(forKey: key)
        }
        if let data = try toData(value) {
            try save(data: data, in: key.rawValue)
        } else {
            throw Error.unsupportedType
        }
    }

    public func get<T>(forKey key: StorageKey) throws -> T? {
        let data = try load(from: key.rawValue)
        guard let value = valueFrom(data) as? T else {
            throw Error.unsupportedType
        }
        return value
    }

    public func add<T>(_ value: T?, forKey key: StorageKey) throws {
        guard try get(forKey: key) == nil else {
            throw Error.duplicateEntry
        }
        guard let value = value else {
            return try remove(forKey: key)
        }
        if let data = try toData(value) {
            try save(data: data, in: key.rawValue)
        } else {
            throw Error.unsupportedType
        }
    }

    public func remove(forKey key: StorageKey) throws {
        try delete(filename: key.rawValue)
    }

    public func purge() throws {
        try deleteAll()
    }

    public func toData(_ value: Any) throws -> Data? {
        guard let data = value as? Data else {
            return try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: false)
        }
        return data
    }
    
    public func valueFrom(_ data: Data) -> Any {
        guard let object = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data)
        else { return data }
        return object
    }
}
