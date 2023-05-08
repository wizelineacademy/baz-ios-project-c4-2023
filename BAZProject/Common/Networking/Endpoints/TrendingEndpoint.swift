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
        case .upcoming: return "/3/movie/upcoming"
        case .nowPlaying: return "/3/movie/now_playing"
        case .topRated: return "/3/movie/top_rated"
        case .popular: return "/3/movie/popular"
        }
    }
    private var section: TrendingMediaSection
    
    init(section: TrendingMediaSection) {
        self.section = section
    }
    
}
