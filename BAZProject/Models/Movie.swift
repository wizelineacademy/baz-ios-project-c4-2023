//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct MoviesResult: Decodable {
    var arrMovies: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case arrMovies = "results"
    }
    
}
struct Movie: Decodable{
    
    var title               : String?
    var adult               : Bool = false
    var backdropPath        : String?
    var genreIds            : [Int]
    var id                  : Int?
    var mediaType           : String?
    var posterPath          : String?
    var originalLanguage    : String?
    var originalTitle       : String?
    var overview            : String?
    var popularity          : Double?
    var releaseDate         : String?
    var video               : Bool = false
    var voteAverage         : Float?
    var voteCount           : Int?
    
    enum CodingKeys: String, CodingKey {
        case title
        case adult
        case backdropPath       = "backdrop_path"
        case genreIds           = "genre_ids"
        case id
        case mediaType          = "media_type"
        case posterPath         = "poster_path"
        case originalLanguage   = "original_language"
        case originalTitle      = "original_title"
        case overview
        case popularity
        case releaseDate        = "release_date"
        case video
        case voteAverage        = "vote_average"
        case voteCount          = "vote_count"
    }
    
}
