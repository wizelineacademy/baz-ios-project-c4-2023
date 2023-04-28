//
//  ServiceProtocol.swift
//  BAZProject
//
//  Created by nmorenoa on 29/03/23.
//

import Foundation
protocol Service {
    var session: URLSessionProtocol { get }
    func getMovies<T:Decodable>(_ request: URLRequest, callback: @escaping (Result<T, Error>) -> Void)
}

extension Service{
    /**
    This Function is generic, makes a request to a service,
    
    - Parameters:
       - endpoint: Is an enum that indicates what request it sends.
    
    - Returns:
       - T: return The type of the value to decode from the supplied JSON object.
       - Error: returns the service error
    */
    func getMovies<T:Decodable>(_ request: URLRequest, callback: @escaping (Result<T, Error>) -> Void) {
        let task = self.session.performDataTask(with: request) { (data, response, error) in
            guard let data: Data = data else { return callback(.failure(error ?? NSError())) }
            do {
                let decodedData: T = try JSONDecoder().decode(T.self, from: data)
                callback(.success(decodedData))
            } catch {
                callback(.failure(error))
            }
        }
        task.resume()
    }
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

protocol URLSessionProtocol { typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}
