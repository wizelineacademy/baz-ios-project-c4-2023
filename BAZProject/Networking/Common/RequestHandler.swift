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
    
    func get(_ endpoint: EndpointProtocol, completion: @escaping (Result<Data , RequestHandlerError>) -> Void) {
        
        guard let request = endpoint.request else {
            completion(.failure(.requestBuilder))
            return
        }
        
        urlSession.customDataTask(with: request) { data, response, error in
            if let error = error as? NSError {
                completion(.failure(.serviceError(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.nullData))
                return
            }
            completion(.success(data))
                      
        }.resume()
    }
    
}
