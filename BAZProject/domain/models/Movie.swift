//
//  Movie.swift
//  BAZProject
//
//

import Foundation

/*struct Movie {
    let id: Int
    let title: String
    let poster_path: String
    let overview: String
    let vote_average: Float
    let release_date: String
}*/

struct MoviesResponse: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String
    let voteAverage: Float
    let releaseDate: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case voteAverage = "vote_average"
        case releaseDate = "release_date"
    }
}