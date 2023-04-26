//
//  ServiceMock.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 04/04/23.
//

import Foundation
@testable import BAZProject

final class ServiceMock: ServiceProtocol {
    
    var session: URLSessionProtocol
    
    init(sessionMock: URLSessionProtocol) {
        self.session = sessionMock
    }
    
    func get<T>(_ endpoint: URL, callback: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        ServiceAPI(session: session).get(endpoint, callback: callback)
    }
    
}
