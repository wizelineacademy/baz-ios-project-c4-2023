//
//  OptionMovie.swift
//  BAZProject
//
//  Created by nmorenoa on 09/04/23.
//
import UIKit
enum OptionMovie {
    case getMovieDay
    case getNowPlaying
    case getPopular
    case getTopRated
    case getUpcoming
    case searchMovie(String)
    case getReviews(Int)
    case getRecomendations(Int)
    case getSimilars(Int)
}
extension OptionMovie: Endpoint{
    
    var path: String {
        switch self {
        case .getMovieDay: return "/3/trending/movie/day"
        case .getNowPlaying: return "/3/movie/now_playing"
        case .getPopular: return "/3/movie/popular"
        case .getTopRated: return "/3/movie/top_rated"
        case .getUpcoming: return "/3/movie/upcoming"
        case .searchMovie: return "/3/search/movie"
        case .getReviews(let idMovie): return "/3/movie/\(idMovie)/reviews"
        case .getRecomendations(let idMovie): return "/3/movie/\(idMovie)/recommendations"
        case .getSimilars(let idMovie): return "/3/movie/\(idMovie)/similar"
        }
    }
    
    var request: URLRequest {
        return URLRequest(url: url?.url ?? URL(fileURLWithPath: ""))
    }
    
    var url: URLComponents? {
        var components = URLComponents(string: baseURL)
        components?.path = path
        var queryItems = [URLQueryItem]()
        queryItems.append(apiKey)
        switch self {
        case .searchMovie(let txtSearch):
            let queryItem = URLQueryItem(name: "query",
                                          value: txtSearch.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
            queryItems.append(queryItem)
        default: break
        }
        components?.queryItems = queryItems
        return components
    }
    
}
