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
    case recommended(id: Int)
    case pupular(page: Int)
    case newMovies(page: Int)
    case video(id:Int)
}

extension MovieApi: EndPointType {
    // TODO: (SDA) Maybe we do not need environment
    var environmentBaseURL: String {
        switch NetworkManager.environment {
        case .production: return "https://api.themoviedb.org/3/movie/" // TODO: (SDA) This is the good one
        case .qa: return "http://qa.api.themoviedb.org/3/movie/"
        case .staging: return "http://staging.api.themoviedb.org/3/movie/"
        }
    }
    
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.") }
        return url
    }
    
    var path: String {
        switch self {
        case .recommended(let id):
            return "\(id)/recomendations"
        case .pupular:
            return "popular"
        case .newMovies:
            return "now_playing"
        case .video(let id):
            return "\(id)/videos"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .newMovies(let page):
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: ["page": page,
                                                      "api_key": NetworkManager.MovieApiKey])
        default:
            return .request
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
