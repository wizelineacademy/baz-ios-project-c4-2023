//
//  Extensions.swift
//  BAZProject
//
//  Created by gescarcega on 30/03/23.
//

import Foundation

extension Decodable {
    
    public init?(data: Data) throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        self = try decoder.decode(Self.self, from: data)
    }
    
}
