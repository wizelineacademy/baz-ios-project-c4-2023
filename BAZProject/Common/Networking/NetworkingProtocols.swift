//
//  NetworkingProtocols.swift
//  BAZProject
//
//  Created by gescarcega on 30/03/23.
//

import Foundation
 
protocol RequestSessionProtocol {
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
    
}

extension URLSession: RequestSessionProtocol { }

protocol EndpointProtocol {
    
    var path: String { get }
    var scheme: String? { get }
    var host: String? { get }
    var key: String? { get }
    var queries: [URLQueryItem]? { get }
    var cachePolicy: URLRequest.CachePolicy { get }
    func getRequest() -> URLRequest?
    
}

extension EndpointProtocol {
    
    var scheme: String? { return "https" }
    var host: String? { return "api.themoviedb.org" }
    var key: String? { return "f6cd5c1a9e6c6b965fdcab0fa6ddd38a" }
    var queries: [URLQueryItem]? { return nil }
    var cachePolicy: URLRequest.CachePolicy { return .useProtocolCachePolicy}
    
    func getRequest() -> URLRequest? {
        var queriesCopy = queries
        if let keyCopy = key {
            if queriesCopy == nil {
                queriesCopy = [URLQueryItem(name: "api_key", value: keyCopy)]
            } else {
                queriesCopy?.append(URLQueryItem(name: "api_key", value: keyCopy))
            }
        }
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = queriesCopy
        guard let url = components.url else { return nil }
        return URLRequest(url: url, cachePolicy: cachePolicy)
    }
    
}
