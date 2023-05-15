//
//  MovieServiceMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 28/03/23.
//

import Foundation
@testable import BAZProject

enum ServiceMockCalls {
    case get
    case fetchImageData
}

final class ServiceMock: Service {
    var session: URLSessionProtocol
    var calls: [ServiceMockCalls] = []
    
    init(sessionMock: URLSessionProtocol) {
        self.session = sessionMock
    }
    
    func get<T>(_ endpoint: EndPointProtocol, callback: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        calls.append(.get)
        ServiceAPI(session: session).get(endpoint, callback: callback)
    }

    func fetchImageData(urlString: String, completion: @escaping (Data?) -> Void) {
        calls.append(.fetchImageData)
        ServiceAPI(session: session).fetchImageData(urlString: urlString, completion: completion)
    }
}
