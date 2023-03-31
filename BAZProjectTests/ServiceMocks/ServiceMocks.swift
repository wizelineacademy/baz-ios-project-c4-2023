//
//  ServiceMocks.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 31/03/23.
//

import Foundation
@testable import BAZProject

final class ServiceMocks: Service {
    
    var session: URLSessionProtocol
    
    init(sessionMock: URLSessionProtocol) {
        self.session = sessionMock
    }
    
    func getMovies(_ endpoint: Endpoint, callback: @escaping (Result<[Movie], Error>) -> Void) {
        MovieAPI(session: session).getMovies(endpoint, callback: callback)
    }
    
}
