//
//  PersistenceProtocol.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 11/05/23.
//

import Foundation

public protocol PersistenceProtocol {
    func save<T: Codable>(info objInfo: T)
    func getAll<T: Codable>() -> [T]
    func delete<T: Codable>(info objInfo: T)
}
