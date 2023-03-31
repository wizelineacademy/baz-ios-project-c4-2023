//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie: Decodable {
    let id: Int
    let title: String
    let poster_path: String
}

struct TrendingMovieResult: Decodable{
    let results:  [Movie]
}
