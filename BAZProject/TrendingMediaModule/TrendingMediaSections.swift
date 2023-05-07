//
//  TrendingMediaSections.swift
//  BAZProject
//
//  Created by gescarcega on 07/05/23.
//

import Foundation

public enum TrendingMediaSection: Int, SectionProtocol {
    
    case trending, nowPlaying, popular, topRated, upcoming
    
    public var title: String? {
        switch self {
        case .trending: return "Trending"
        case .nowPlaying: return "Now Playing"
        case .popular: return "Popular"
        case .topRated: return "Top Rated"
        case .upcoming: return "Coming Soon"
        }
    }
}
