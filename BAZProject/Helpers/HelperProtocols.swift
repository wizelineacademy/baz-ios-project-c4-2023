//
//  HelperProtocols.swift
//  BAZProject
//
//  Created by 989438 on 04/04/23.
//

import Foundation

protocol HelperProtocol {
    func save<T>(_ item: T, service: String, account: String) where T : Codable
    func read<T>(service: String, account: String, type: T.Type) -> T? where T : Codable
}
