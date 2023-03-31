//
//  EndpointExtension.swift
//  BAZProject
//
//  Created by 989438 on 31/03/23.
//

import Foundation

extension Endpoint: EndPointProtocol {
    var string: String {
        switch self {
        case .trending:
            return MainConstants.trendingEndPoint
        case .nowPlaying:
            return MainConstants.nowPlayingEndPoint
        case .popular:
            return MainConstants.popularEndPoint
        case .topRated:
            return MainConstants.topRatedEndPoint
        case .upcoming:
            return MainConstants.upcomingEndPoint
        }
    }
    
    var request: URLRequest {
        let url: URL = URL(string: Endpoint.baseURL + string) ?? URL(fileURLWithPath: "")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
