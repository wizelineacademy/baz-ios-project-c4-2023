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

struct TradingMovieResult: Decodable{
    let results:  [Movie]
}
