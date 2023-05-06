//
//  MovieEndPoint.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 24/04/23.
//

import Foundation

// TODO: (SDA) Maybe we do not need environment
enum NetworkEnvironment {
    case qa
    case production
    case staging
}

public enum MovieApi {
    case trending(page: Int)
    case nowPlaying(page: Int)
    case pupular(page: Int)
    case topRated(page: Int)
    case upcoming(page: Int)
    case newMovies(page: Int) // TODO: (SDA) Erase this case
    case cast(movieId: Int)
    case similar (movieId: Int)
    case recommendations (movieId:Int)
    case reviews (movieId: Int)
    case multi (searching: String)
}

extension MovieApi: EndPointType {
    // TODO: (SDA) Maybe we do not need environment
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "https://api.themoviedb.org/3/" // TODO: (SDA) This is the good one
        case .qa: return "http://qa.api.themoviedb.org/3/movie/"
        default: return ""
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .trending:
            return "trending/movie/day"
        case .nowPlaying:
            return "movie/now_playing"
        case .pupular:
            return "movie/popular"
        case .topRated:
            return "movie/top_rated"
        case .upcoming:
            return "movie/upcoming"
        case .newMovies:
            return "movie/now_playing" // TODO: (SDA) Erase this case
        case .cast(let movieId):
            return "movie/\(movieId)/credits"
        case .similar(let movieId):
            return "movie/\(movieId)/similar"
        case .recommendations(let movieId):
            return "movie/\(movieId)/recommendations"
        case .reviews(let movieId):
            return "movie/\(movieId)/reviews"
        case .multi(let searching):
            return "/search/multi"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .trending(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key": NetworkManager.MovieApiKey,
                                                      "page": page])
        case .nowPlaying(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key": NetworkManager.MovieApiKey,
                                                      "page": page])
        case .pupular(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key": NetworkManager.MovieApiKey,
                                                      "page": page])
        case .topRated(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key": NetworkManager.MovieApiKey,
                                                      "page": page])
        case .upcoming(let page):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key": NetworkManager.MovieApiKey,
                                                      "page": page])
        case .newMovies(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key": NetworkManager.MovieApiKey,
                                                      "page": page])
        case .cast(let movieId):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key": NetworkManager.MovieApiKey])
        case .similar(let movieId):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key": NetworkManager.MovieApiKey])
        case .recommendations(let movieId):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key": NetworkManager.MovieApiKey])
        case .reviews(let movieId):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key": NetworkManager.MovieApiKey,
                                                      "language": "es"])
        case .multi(let searching):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["api_key": NetworkManager.MovieApiKey,
                                                      "query": "\(searching)",
                                                      "page": 1])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
