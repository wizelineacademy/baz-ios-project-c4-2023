//
//  EndPoint.swift
//  BAZProject
//
//  Created by nmorenoa on 29/03/23.
//

import Foundation

enum Endpoint {
    static let baseURL          = "https://api.themoviedb.org/3/trending/movie/day"
    static let apiKey: String   = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    case getMovies
}
extension Endpoint{
    var request: URLRequest {
        switch self {
        case .getMovies:
            let url: URL = URL(string: Endpoint.baseURL + Endpoint.apiKey) ?? URL(fileURLWithPath: "")
            let request = URLRequest(url: url)
            return request
        }
    }
}
