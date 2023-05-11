//
//  JSONParameterEncoder.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 11/04/23.
//

import Foundation

// TODO: (SDA) Consider unit tests in this encoder, this piece of code encodes the parameters to JSON and adds apporpiate headers
public struct JSONParameterEncoder: ParameterEncoder {
    
    public static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        do {
            let jsonAsData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            urlRequest.httpBody = jsonAsData
            if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        } catch {
            throw NetworkError.encodingFailed
        }
    }
    
}
