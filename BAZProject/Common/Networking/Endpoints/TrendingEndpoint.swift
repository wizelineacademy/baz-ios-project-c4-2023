//
//  TrendingEndpoint.swift
//  BAZProject
//
//  Created by gescarcega on 04/04/23.
//

import Foundation

struct TrendingEndpoint: EndpointProtocol {
    
    var queries: [URLQueryItem]? { return nil }
    var path: String {
        switch section {
        case .trending: return "/3/trending/all/week"
        case .upcoming: return "/movie/upcoming"
        case .nowPlaying: return "/movie/now_playing"
        case .topRated: return "/movie/top_rated"
        case .popular: return "/movie/popular"
        }
    }
    private var section: TrendingMediaSection
    
    init(section: TrendingMediaSection) {
        self.section = section
    }
    
}
