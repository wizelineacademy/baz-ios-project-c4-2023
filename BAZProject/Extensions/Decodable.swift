//
//  Extensions.swift
//  BAZProject
//
//  Created by gescarcega on 30/03/23.
//

import Foundation

extension Decodable {
    
    init?(data: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: data)
    }

}
