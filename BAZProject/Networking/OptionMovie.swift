//
//  OptionMovie.swift
//  BAZProject
//
//  Created by nmorenoa on 09/04/23.
//
import UIKit
enum OptionMovie {
    case getMovieDay
}
extension OptionMovie: Endpoint{
    
    var baseURL: String {
        return "https://api.themoviedb.org/3/trending/"
    }
    
    var path: String {
        switch self {
        case .getMovieDay: return "movie/day"
        }
    }
    
    var apiKey: String {
        return "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    }
    
    var request: URLRequest {
        return URLRequest(url: url)
    }
    
    var url: URL {
        return URL(string: baseURL + path + apiKey) ?? URL(fileURLWithPath: "")
    }
    
}
