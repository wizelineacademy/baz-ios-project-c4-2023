//
//  RequestHandler.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import Foundation

class RequestHandler {
    
    var urlSession: RequestSessionProtocol
    
    init(withSession urlSessions: RequestSessionProtocol) {
        self.urlSession = urlSessions
    }
    
    func get(_ endpoint: EndpointProtocol) async throws -> Data {
        guard let request = endpoint.getRequest() else { throw RequestHandlerError.requestBuilder }
        let (data, response) = try await urlSession.data(for: request)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw RequestHandlerError.badResponse }
        return data
    }
    
}
