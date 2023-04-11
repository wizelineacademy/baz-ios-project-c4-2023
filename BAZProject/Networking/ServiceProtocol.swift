//
//  ServiceProtocol.swift
//  BAZProject
//
//  Created by nmorenoa on 29/03/23.
//

import Foundation
protocol Service {
    var session: URLSessionProtocol { get }
    func getMovies(_ endpoint: OptionMovie, callback: @escaping (Result<[Movie],Error>) -> Void)
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

protocol URLSessionProtocol { typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}
