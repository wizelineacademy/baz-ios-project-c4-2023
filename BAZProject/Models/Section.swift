//
//  Section.swift
//  BAZProject
//
//  Created by Carlos Garcia on 19/04/23.
//

import Foundation

enum Sections: CaseIterable {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    
    var title: String {
        switch self {
        case .trending:
            return "Trending"
        case .nowPlaying:
            return "Now Playing"
        case .popular:
            return "Popular"
        case .topRated:
            return "Top Rated"
        case .upcoming:
            return "Upcoming"
        }
    }
}

struct Section: MovieSection {
    var strTitle: String
    var movies: [MovieInfo]
    
    init(title: String, movies: [MovieInfo] = []) {
        self.strTitle = title
        self.movies = movies
    }
}
