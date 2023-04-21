//
//  ServiceProtocols.swift
//  BAZProject
//
//  Created by Manuel S on 18/04/23.
//

import Foundation
//MARK: Protocolos de servicios
public protocol Service {
    var session: URLSessionProtocol { get }
    func get<T: Decodable>(_ endpoint: URL, callback: @escaping (Result<T,Error>) -> Void)
}

public protocol URLSessionDataTaskProtocol {
    func resume()
}

public protocol URLSessionProtocol {
    typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

public enum ServiceError: Error {
    case noData
    case parsingData
    case error
}


//MARK: Extensiones
extension URLSessionDataTask: URLSessionDataTaskProtocol {}

extension URLSession: URLSessionProtocol {
    public func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as URLSessionDataTaskProtocol
    }
}
