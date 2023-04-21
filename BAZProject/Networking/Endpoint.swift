//
//  Endpoint.swift
//  BAZProject
//
//  Created by jmgarciaca on 30/03/23.
//

import Foundation

/**
An enumeration representing the endpoints of the The Movie Database API.
*/
enum Endpoint {
    
    /// The base URL for the API.
    static let base = "https://api.themoviedb.org/3"

    /// The API key required to make requests to the API.
    static let apiKey = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"

    /// Represents the endpoint for getting trending movies.
    case trending

    /// Represents the endpoint for getting movies that are currently playing in theaters.
    case nowPlaying

    /// Represents the endpoint for getting popular movies.
    case popular

    /// Represents the endpoint for getting top rated movies.
    case topRated

    /// Represents the endpoint for getting upcoming movies.
    case upcoming

    /// Represents the endpoint for searching for movies with the given query.
    case search(query: String)
}

/**
This extension adds a computed property "url" to the Endpoint enum in Swift. This property returns an optional URL value.

Note: The URL value is constructed using a base URL, an API key and a path, based on the enum case.
*/
extension Endpoint {
    
    /// Computed property that returns a URL constructed from the Endpoint enum case
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
            
            // If query parameter is not URL encoded, it is encoded and added to the URL string
            guard let query = query.urlEncoded() else { break }
            
            return URL(string: "\(Endpoint.base)\(path)\(Endpoint.apiKey)&query=\(query)")
        }
        
        // Returns the URL constructed from the base URL, API key and path
        return URL(string: "\(Endpoint.base)\(path)\(Endpoint.apiKey)")
    }
}
