//
//  NetworkingProtocols.swift
//  BAZProject
//
//  Created by gescarcega on 30/03/23.
//

import Foundation
 
protocol RequestSessionProtocol {
    func customDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskProtocol
}

extension URLSession: RequestSessionProtocol {
    func customDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> DataTaskProtocol {
        return dataTask(with: request, completionHandler: completionHandler) as DataTaskProtocol
    }
}

protocol EndpointProtocol {
    var request: URLRequest? { get }
}

protocol DataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: DataTaskProtocol {}
