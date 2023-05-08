//
//  StorageProtocol.swift
//  BAZProject
//
//  Created by 989438 on 08/05/23.
//

import Foundation

public protocol StorageProtocol {
    func set<T>(_ value: T?, forKey key: StorageKey) throws
    func get<T>(forKey key: StorageKey) throws -> T?
    func remove(forKey key: StorageKey)
}

public extension StorageProtocol {
    func store<T>(_ value: T?, forKey key: StorageKey, usingEncoder encoder: JSONEncoder = .init()) throws where T: Encodable {
        let data = try encoder.encode(value)
        try set(data, forKey: key)
    }

    func retrieve<T>(_ type: T.Type, forKey key: StorageKey, usingDecoder decoder: JSONDecoder = .init()) throws -> T? where T: Decodable {
        guard let data: Data = try get(forKey: key) else {
            return nil
        }
        return try decoder.decode(T.self, from: data) as T
    }
}
