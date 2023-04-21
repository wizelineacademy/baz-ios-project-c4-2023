//
//  ApiConstans.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 19/04/23.
//

import Foundation

struct ApiConstans {
    static var baseURL = "https://api.themoviedb.org/3/"
    static var trending = "trending/movie/day"
    static var apiKey = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    static var baseUrlImage = "https://image.tmdb.org/t/p/w500"
    static var search = "search/movie"
}

public enum ApiError: Error{
    case defaultError
    
    var localizedDescription: String {
        switch self {
        case .defaultError:
            return "Error por defecto"
        }
    }
}
