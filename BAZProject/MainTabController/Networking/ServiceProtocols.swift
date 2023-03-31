//
//  ServiceProtocols.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import Foundation

protocol Service {
    var session: URLSessionProtocol { get }
    /**
     Function generic to perform an API request.
     
     - Parameters:
         - endpoint: Represents a string of the endPoint to perform a request.
         - completion: Returns a generic value or an error.
     */
    func get<T: Decodable>(_ endpoint: EndPointProtocol, callback: @escaping (Result<T,Error>) -> Void)
    /**
     Function that perform an request to download an image data from an Url.
     
     - Parameters:
         - urlString: Represents a string of the url image.
         - completion: Returns image Data.
     */
    func fetchImageData(urlString: String, completion: @escaping (Data?) -> Void)
}

protocol URLSessionDataTaskProtocol {
    func resume()
}

protocol URLSessionProtocol { typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
    func performDataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTaskProtocol
}

protocol EndPointProtocol {
    static var baseURL: String { get }
    var string: String { get }
    var request: URLRequest { get }
}
