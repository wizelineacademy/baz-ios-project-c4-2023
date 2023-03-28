//
//  EndPoint.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import Foundation

// "https://api.themoviedb.org/3/trending/movie/day?api_key=\(MainConstants.apiKey)"

enum Endpoint {
    static let baseURL = "https://api.themoviedb.org/3/"
    
    case trending
}

extension Endpoint {
    var string: String {
        switch self {
        case .trending:
            return MainConstants.trendingEndPoint
        }
    }
    
    var request: URLRequest {
        switch self {
        case .trending:
            let url: URL = URL(string: Endpoint.baseURL + string) ?? URL(fileURLWithPath: "")
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            return request
        }
    }
}
