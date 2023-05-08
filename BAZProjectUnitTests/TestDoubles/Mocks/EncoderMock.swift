//
//  EncoderMock.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 07/05/23.
//

import Foundation

class EncoderMock: JSONEncoder {
    
    var error: Error?
    
    override func encode<T>(_ value: T) throws -> Data where T : Encodable {
        if let error = error {
            throw error
        } else {
            return try super.encode(value)
        }
    }
    
}
