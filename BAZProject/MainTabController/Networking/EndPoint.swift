//
//  EndPoint.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import Foundation

// "https://api.themoviedb.org/3/trending/movie/day?api_key=\(MainConstants.apiKey)"

enum Endpoint {
    static var baseURL = "https://api.themoviedb.org/3/"
    
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
}

extension Endpoint {
    var string: String {
        switch self {
        case .trending:
            return MainConstants.trendingEndPoint
        case .nowPlaying:
            return MainConstants.nowPlayingEndPoint
        case .popular:
            return MainConstants.popularEndPoint
        case .topRated:
            return MainConstants.topRatedEndPoint
        case .upcoming:
            return MainConstants.upcomingEndPoint
        }
    }
    
    var request: URLRequest {
        let url: URL = URL(string: Endpoint.baseURL + string) ?? URL(fileURLWithPath: "")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
