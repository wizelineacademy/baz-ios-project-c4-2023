//
//  EncoderDecoderSpy.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 07/05/23.
//

import Foundation

class EncoderSpy: JSONEncoder {
    
    var error: Error?
    
    override func encode<T>(_ value: T) throws -> Data where T : Encodable {
        if let error = error {
            throw error
        } else {
            return try super.encode(value)
        }
    }
    
}

class DecoderSpy: JSONDecoder {
    
    var error: Error?
    
    override func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        if let error = error {
            throw error
        } else {
            return try super.decode(type, from: data)
        }
    }

}
