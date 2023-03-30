//
//  RequestHandler.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import Foundation

class RequestHandler {
    
    func get(_ endpoint: Endpoint, completion: @escaping (Result<Data , RequestHandlerError>) -> Void) {
        
        guard let request = endpoint.request else {
            completion(.failure(.requestBuilder))
            return
        }
        
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error as? NSError {
                    DispatchQueue.main.async {
                        completion(.failure(.serviceError(error)))
                    }
                    return
                }
                
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(.nullData))
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(.success(data))
                }
                      
            }.resume()
        }
    }
    
}
