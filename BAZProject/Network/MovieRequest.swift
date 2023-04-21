//
//  MovieEndpoints.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 03/04/23.
//

import Foundation
import UIKit

class MovieRequest: NSObject {
    static let baseURL: String = "https://api.themoviedb.org/3/"
    static let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    static func getURL(endpoint: Endpoint) -> URL? {
        let endpoint = endpoint.rawValue
        let requestURL: String = baseURL+endpoint+"?api_key=\(apiKey)"
        return URL(string: requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    
    static func searchMovie(search query: String, allowAdultResults: Bool = false) -> URL? {
        let endpoint = Endpoint.searchMovies.rawValue+"?api_key=\(apiKey)"
        let requestURL: String = baseURL+endpoint+"&query=\(query)&include_adult=\(allowAdultResults)"
        return URL(string: requestURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")
    }
    
}

enum Endpoint: String {
    case trendingMovies = "trending/movie/day"
    case topRatedMovies = "movie/top_rated"
    case recentsMovies = "movie/now_playing"
    case upcomingMovies = "movie/upcoming"
    case searchMovies = "search/movie"
    case movieDetail = "movie"
}

struct Response<T: Codable>: Codable {
    var page: Int?
    var results: T?
    var total_pages: Int?
    var total_results: Int?
}
