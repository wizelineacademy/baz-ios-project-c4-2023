//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct MoviesResult: Decodable {
    var movies: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
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
struct MoviesSearchResult: Decodable {
    var movies          : [Movie]?
    var page            : Int?
    var totalPages      : Int?
    var totalResults    : Int?
    
    enum CodingKeys: String, CodingKey {
        case movies         = "results"
        case page
        case totalPages     = "total_pages"
        case totalResults   = "total_results"
    }
    
}
