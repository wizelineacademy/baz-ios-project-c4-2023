//
//  Endpoint.swift
//  BAZProject
//
//  Created by jmgarciaca on 30/03/23.
//

import Foundation

enum Endpoint {
    
    /// TODO: meter mas documentación
    static let base = "https://api.themoviedb.org/3"
    static let apiKey = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case search(query:String)
}

extension Endpoint {
    
    var url: URL? {
        
        var path = ""
        
        switch self {
        case .trending:
            path = "/trending/movie/day"
        case .nowPlaying:
            path = "/movie/now_playing"
        case .popular:
            path = "/movie/popular"
        case .topRated:
            path = "/movie/top_rated"
        case .upcoming:
            path = "/movie/upcoming"
        case .search(query: let query):
            path = "/search/movie"
            
            guard let query = query.urlEncoded() else { break }
            
            return URL(string: "\(Endpoint.base)\(path)\(Endpoint.apiKey)&query=\(query)")
        }
        
        return URL(string: "\(Endpoint.base)\(path)\(Endpoint.apiKey)")
    }
}
