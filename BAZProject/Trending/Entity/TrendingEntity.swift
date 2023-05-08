//
//  TrendingEntity.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import Foundation
import UIKit

struct TrendingEntity {
    
    var strNavBarTitle : String = "" //TODO: Set the nav bar title
    var result : [Movie]?
    var movieDetailData: MoviesHomeData = MoviesHomeData()
    
}

struct TrendingMovieResult: Decodable{
    let results:  [Movie]
}

struct MoviesHomeData {
    var trendingMovies: ListSectionMovieHome = {
        .trendingMovies([])
        
    }()
    var nowPlayingMovies: ListSectionMovieHome = {
        .nowPlayingMovies([])
        
    }()
    var popular: ListSectionMovieHome = {
        .popular([])
        
    }()
    var topRated: ListSectionMovieHome = {
        .topRated([])
        
    }()
    var upcoming: ListSectionMovieHome = {
        .upcoming([])
        
    }()
    
    var pageData: [ListSectionMovieHome] {
        [trendingMovies, nowPlayingMovies, popular, topRated, upcoming]
    }
}

enum ListSectionMovieHome {
    case trendingMovies([Movie])
    case nowPlayingMovies([Movie])
    case popular([Movie])
    case topRated([Movie])
    case upcoming([Movie])
    
    var items: [Movie] {
        switch self{
        case .trendingMovies(let items), .nowPlayingMovies(let items), .popular(let items), .topRated(let items), .upcoming(let items):
            return items
        }
    }
    
    var count: Int{
        items.count
    }
    
    var title: String{
        switch self {
        case .trendingMovies:
            return "Trending"
        case .nowPlayingMovies:
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
