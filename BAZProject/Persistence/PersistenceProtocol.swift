//
//  PersistenceProtocol.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 11/05/23.
//

import Foundation

public protocol StorableObject: Codable {
    var id: Int { get }
}

public protocol PersistenceProtocol {
    func save<T: StorableObject>(info objInfo: T)
    func getAll<T: StorableObject>() -> [T]?
    func delete<T: StorableObject>(info objInfo: T)
}
