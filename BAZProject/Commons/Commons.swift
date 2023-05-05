//
//  Commons.swift
//  BAZProject
//
//  Created by Manuel S on 25/04/23.
//

import UIKit

/// Enumerador para menejar las ulrs del proyecto
enum urls: String {
    case apikey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
}

/// Enum used to store the icons used through the app.
enum Icon {
    static let heart: UIImage = UIImage(systemName: "heart") ?? UIImage()
    static let heartFill: UIImage = UIImage(systemName: "heart.fill") ?? UIImage()
}

/// Enumerador para menejar las datos de la aplicacion
enum Constant {
    static let favoritesCellHeight = 150.0
}

/// Enumerador para UserDefauls
enum DefaultsKey: String {
    case favorites = "favoritesMovies"
    case favoriteTests = "favoriteTests"
}

/// Enumerador para Manejo de titulos
enum StringsTitles: String {
    case favorites = "Favoritos"
    case search = "buscar"
    case treding = "Trending"
}

/// Enumerador para menejar de los tipos y sus urls
enum CategoriesFilter: String {
    case trending = "Trending"
    case nowPlaying = "Now Playing"
    case popular = "Popular"
    case topRated = "Top Rated"
    case upcoming = "Upcoming"
    case search =  "Search"
    case recommendation = "Recommendation Movies"
    case similar = "similar Movies"
    case cast = "cast"
    
    var url: String {
        let baseURL = "https://api.themoviedb.org/3/movie/"
        switch self {
        case .trending:
            return "https://api.themoviedb.org/3/trending/movie/day?api_key="
        case .nowPlaying:
            return "\(baseURL)now_playing?api_key="
        case .popular:
            return "\(baseURL)popular?api_key="
        case .topRated:
            return "\(baseURL)top_rated?api_key="
        case .upcoming:
            return "\(baseURL)upcoming?api_key="
        case .search:
            return "https://api.themoviedb.org/3/search/movie?api_key="
        case .recommendation, .similar, .cast:
            return baseURL
        }
    }
}
