//
//  ServiceMocks.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 31/03/23.
//

import Foundation
import XCTest
@testable import BAZProject

final class ServiceMocks: Service {
    
    var session: URLSessionProtocol
    
    init(sessionMock: URLSessionProtocol) {
        self.session = sessionMock
    }
    
    func getMovies<T>(_ request: URLRequest, callback: @escaping (Result<T, Error>) -> Void)  where T : Decodable {
        MovieAPI(session: session).getMovies(request, callback: callback)
    }
    
}
class UrlSessionDataTaskMock: URLSessionDataTaskProtocol {
    func resume() {}
}
