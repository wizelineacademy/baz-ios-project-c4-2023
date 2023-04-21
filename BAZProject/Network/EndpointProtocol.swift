//
//  EndpointProtocol.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 03/04/23.
//

import Foundation

protocol URLSessionDataTaskProtocol {
    func resume()
}

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol ServiceProtocol {
    var session: URLSessionProtocol { get }
    func get<T: Decodable>(_ endpoint: URL, callback: @escaping (Result<T,Error>) -> Void)
}

extension URLSession: URLSessionProtocol {
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {
    
}
