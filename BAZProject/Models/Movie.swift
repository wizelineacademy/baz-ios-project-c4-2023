//
//  Movie.swift
//  BAZProject
//
//

import Foundation
//Movie
struct Movie: Decodable {
    public var arrMovies: [MoviesResult]?
    
    enum CodingKeys: String, CodingKey {
        case arrMovies = "results"
    }
    
}
struct MoviesResult: Decodable{
    
    let strTitle        : String?
    let strPosterPath   : String?
    
    enum CodingKeys: String, CodingKey {
        case strTitle       = "title"
        case strPosterPath  = "poster_path"
    }
    
}
