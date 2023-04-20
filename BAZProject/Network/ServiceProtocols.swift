//
//  ServiceProtocols.swift
//  BAZProject
//
//  Created by Manuel S on 18/04/23.
//

import Foundation
//MARK: Protocolos de servicios
protocol Service {
    var session: URLSessionProtocol { get }
    func get<T: Decodable>(_ endpoint: URL, callback: @escaping (Result<T,Error>) -> Void)
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

enum ServiceError: Error {
    case noData
    case parsingData
    case error
}


//MARK: Extensiones
extension URLSessionDataTask: URLSessionDataTaskProtocol {}

extension URLSession: URLSessionProtocol {
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}
