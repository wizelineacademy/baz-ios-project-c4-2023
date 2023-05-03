//
//  HomeEntity.swift
//  BAZProject
//
//  Created by jehernandezg on 02/05/23.
//

import UIKit

struct MovieAPIConstans {
    // MARK: - Constants
    static let apiKey = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    static let baseURL = "https://api.themoviedb.org/3/"
    static let trending = "trending/movie/day\(apiKey)"
    static let nowPlaying = "movie/now_playing\(apiKey)\(searchConfig)"
    static let popular = "movie/popular\(apiKey)\(searchConfig)"
    static let topRated = "movie/top_rated\(apiKey)\(searchConfig)"
    static let upcoming = "movie/upcoming\(apiKey)\(searchConfig)"
    static let search = "search/movie\(apiKey)\(searchConfig)"
    static let searchConfig = "&language=es&page=1&query="
    static let baseUrlImage = "https://image.tmdb.org/t/p/w500"
}

public enum Endpoint {
    static var baseURL = MovieAPIConstans.baseURL
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case search(query: String)
}

extension Endpoint {
    var stringURL: String {
        switch self {
        case .trending:
            return MovieAPIConstans.trending
        case .nowPlaying:
            return MovieAPIConstans.nowPlaying
        case .popular:
            return MovieAPIConstans.popular
        case .topRated:
            return MovieAPIConstans.topRated
        case .upcoming:
            return MovieAPIConstans.upcoming
        case .search(query: let query):
            return "\(MovieAPIConstans.search)\(query.replacingOccurrences(of: " ", with: "%20"))"
        }
    }
    
    var request : URLRequest? {
        let pathURL = URL(string: "\(Endpoint.baseURL)\(stringURL)") ?? URL(fileURLWithPath: "")
        var request = URLRequest(url: pathURL)
        request.httpMethod = "GET"
        return request
    }
}

enum KUserDefaultsKeys: String {
    case kFavorite = "SavedData"
}
