//
//  Commons.swift
//  BAZProject
//
//  Created by Manuel S on 25/04/23.
//

import Foundation

// Metodos extras para el uso de peliculas con Strings
extension String {
    func formatterMovieName() -> String {
        self.replacingOccurrences(of: " ", with: "%20", options: NSString.CompareOptions.literal, range: nil) //Dividir palabras para la busqueda
    }
}

/// enumerador para menejar las ulrs del proyecto
enum urls: String {
    case apikey = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
}


enum categoriesFilter: String {
    case Trending = "Trending"
    case NowPlaying = "Now Playing"
    case Popular = "Popular"
    case TopRated = "Top Rated"
    case Upcoming = "Upcoming"
    case Search =  "Search"
    
    var url: String {
        switch self {
        case .Trending:
            return "https://api.themoviedb.org/3/trending/movie/day?api_key="
        case .NowPlaying:
            return "https://api.themoviedb.org/3/movie/now_playing?api_key="
        case .Popular:
            return "https://api.themoviedb.org/3/movie/popular?api_key="
        case .TopRated:
            return "https://api.themoviedb.org/3/movie/top_rated?api_key="
        case .Upcoming:
            return "https://api.themoviedb.org/3/movie/upcoming?api_key="
        case .Search:
            return "https://api.themoviedb.org/3/search/movie?api_key="
        }
    }
}
