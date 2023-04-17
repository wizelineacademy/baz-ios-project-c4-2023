//
//  EndpointProtocol.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 03/04/23.
//

import Foundation

protocol Service {
    var session: URLSessionProtocol { get }
    func getMovies(_ endpoint: Endpoint, callback: @escaping (Result<[Movie],Error>) -> Void)
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

protocol URLSessionProtocol { typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}
