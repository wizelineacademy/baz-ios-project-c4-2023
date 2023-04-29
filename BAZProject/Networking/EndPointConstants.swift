//
//  EndPointConstants.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import Foundation

enum EndPointConstants {
    // MARK: - Common
    private static let apiKey: String = KeychainHelper.standard.read(type: Auth.self)?.apiKey ?? ""
    static let mediaEndPoint: String = "https://image.tmdb.org/t/p/w500"
    static let trendingEndPoint: String = "trending/movie/day?api_key=\(apiKey)&language=es&region=MX&page=1"
    static let nowPlayingEndPoint: String = "movie/now_playing?api_key=\(apiKey)&language=es&region=MX&page=1"
    static let popularEndPoint: String = "movie/popular?api_key=\(apiKey)&language=es&region=MX&page=1"
    static let topRatedEndPoint: String = "movie/top_rated?api_key=\(apiKey)&language=es&region=MX&page=1"
    static let upcomingEndPoint: String = "movie/upcoming?api_key=\(apiKey)&language=es&region=MX&page=1"
    static let searchMovie: String = "search/movie?api_key=\(apiKey)&language=MX&query="
    static let recommendedEndPoint: String = "/recommendations?api_key=\(apiKey)&language=es&region=MX&page=1"
    static let similarEndPoint: String = "/similar?api_key=\(apiKey)&language=es&region=MX&page=1"
    static let actorsEndPoint: String = "/credits?api_key=\(apiKey)&language=es&region=MX&page=1"
    static let reviewsEndPoint: String = "/reviews?api_key=\(apiKey)&language=es&region=MX&page=1"
}

struct Auth: Codable {
    let apiKey: String
}
