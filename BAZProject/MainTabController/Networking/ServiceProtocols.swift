//
//  ServiceProtocols.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import Foundation

protocol Service {
    var session: URLSessionProtocol { get }
    func get<T: Decodable>(_ endpoint: Endpoint, callback: @escaping (Result<T,Error>) -> Void)
    func fetchImageData(urlString: String, completion: @escaping (Data?) -> Void)
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

protocol URLSessionProtocol { typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}
