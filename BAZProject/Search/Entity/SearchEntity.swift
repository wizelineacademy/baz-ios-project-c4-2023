//
//  SearchEntity.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import Foundation

struct SearchEntity {
    
    var strNavBarTitle : String = "" //TODO: Set the nav bar title
    var result: [SearchedMovies]?
    
    
}

struct SearchedMovies: Decodable, Equatable {
    let id: Int
    let title: String
    let poster_path: String?
}

struct SearchMovieResult: Decodable{
    let results:  [SearchedMovies]
}
