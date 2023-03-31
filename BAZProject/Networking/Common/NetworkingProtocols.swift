//
//  NetworkingProtocols.swift
//  BAZProject
//
//  Created by gescarcega on 30/03/23.
//

import Foundation
 
protocol RequestSessionProtocol {
    func customDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: RequestSessionProtocol {
    func customDataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return dataTask(with: request, completionHandler: completionHandler)
    }
}

protocol EndpointProtocol {
    var request: URLRequest? { get }
}
