//
//  Paths.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 03/04/23.
//

import Foundation

public struct URLConfiguration {
    var strMethod: String
    var strHost: String
    var path: Paths
    private var strCurrentLocale: String {
        if #available(iOS 16.0, *) {
            return Locale.current.language.languageCode?.identifier ?? ""
        } else {
            return Locale.current.identifier
        }
    }
    
    public init(strMethod: String = "https", strHost: String = "api.themoviedb.org", path: Paths) {
        self.strMethod = strMethod
        self.strHost = strHost
        self.path = path
    }
    
    public mutating func updatePath(with path: Paths) {
        self.path = path
    }
    
    public func configureURL() -> URL? {
        guard !strHost.isEmpty else { return nil }
        var components = URLComponents()
        components.scheme = strMethod
        components.host = strHost
        components.path = path.getString()
        switch path {
        case .trending, .nowPlaying, .popular, .topRated, .upcoming, .similarMovies(_), .review(_), .cast(_):
            components.queryItems = configureKeyAndLanguage()
        case .search(let strQuery):
            var arrComponents = configureKeyAndLanguage()
            arrComponents.append(URLQueryItem(name: "query", value: strQuery))
            components.queryItems = arrComponents
        default:
            break
        }
        return components.url
    }
    
    private func configureKeyAndLanguage() -> [URLQueryItem] {
        return [URLQueryItem(name: "api_key", value: "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"),
                URLQueryItem(name: "language", value: strCurrentLocale)]
    }
}

public enum Paths {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case image(strFile: String)
    case search(strQuery: String)
    case similarMovies(strMovieId: String)
    case review(strMovieId: String)
    case cast(strMovieId: String)
    case noPath
    
    func getString() -> String {
        switch self {
        case .trending:
            return "/3/trending/movie/day"
        case .nowPlaying:
            return "/3/movie/now_playing"
        case .popular:
            return "/3/movie/popular"
        case .topRated:
            return "/3/movie/top_rated"
        case .upcoming:
            return "/3/movie/upcoming"
        case .image(let strFile):
            return "/t/p/w500\(strFile)"
        case .search(strQuery: _):
            return "/3/search/movie"
        case .similarMovies(let strMovieId):
            return "/3/movie/\(strMovieId)/recommendations"
        case .review(let strMovieId):
            return "/3/movie/\(strMovieId)/reviews"
        case .cast(let strMovieId):
            return "/3/movie/\(strMovieId)/credits"
        case .noPath:
            return ""
        }
    }
}
