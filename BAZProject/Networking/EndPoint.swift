//
//  EndPoint.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import Foundation

enum Endpoint {
    static var baseURL = NSLocalizedString(MainLocalizableString.baseURLForAPICalls.rawValue, comment: "")
    
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case search(query: String)
}

extension Endpoint: EndPointProtocol {
    var string: String {
        switch self {
        case .trending:
            return EndPointConstants.trendingEndPoint
        case .nowPlaying:
            return EndPointConstants.nowPlayingEndPoint
        case .popular:
            return EndPointConstants.popularEndPoint
        case .topRated:
            return EndPointConstants.topRatedEndPoint
        case .upcoming:
            return EndPointConstants.upcomingEndPoint
        case . search(let query):
            return "\(EndPointConstants.searchMovie)\(query.replacingOccurrences(of: " ", with: "%20"))"
        }
    }
    
    var request: URLRequest {
        let url: URL = URL(string: Endpoint.baseURL + string) ?? URL(fileURLWithPath: "")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
