//
//  MovieServiceMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 28/03/23.
//

import Foundation
@testable import BAZProject

final class ServiceMock: Service {

    var session: URLSessionProtocol
    
    init(sessionMock: URLSessionProtocol) {
        self.session = sessionMock
    }
    
    func get<T>(_ endpoint: EndPointProtocol, callback: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        ServiceAPI(session: session).get(endpoint, callback: callback)
    }

    func fetchImageData(urlString: String, completion: @escaping (Data?) -> Void) {
        ServiceAPI(session: session).fetchImageData(urlString: urlString, completion: completion)
    }
}
