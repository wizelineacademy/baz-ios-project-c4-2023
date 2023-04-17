//
//  ServiceMock.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 04/04/23.
//

import Foundation

@testable import BAZProject

final class ServiceMock: Service {
    var session: URLSessionProtocol
    
    init(sessionMock: URLSessionProtocol) {
        self.session = sessionMock
    }
    
    func getMovies(_ endpoint: Endpoint, callback: @escaping (Result<[Movie], Error>) -> Void) {
        MovieAPI(session: session).getMovies(endpoint, callback: callback)
    }
    
}
