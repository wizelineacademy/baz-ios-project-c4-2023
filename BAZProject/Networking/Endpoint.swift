//
//  Endpoint.swift
//  BAZProject
//
//  Created by jmgarciaca on 30/03/23.
//

import Foundation

enum Endpoint {
    static let base = "https://api.themoviedb.org/3"
    static let apiKey = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    case trendingMovieDay
}

extension Endpoint {
    var url: URL {
        switch self {
        case .trendingMovieDay:
            return URL(string: "\(Endpoint.base)/trending/movie/day\(Endpoint.apiKey)")!
        }
    }
}
