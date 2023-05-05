//
//  Movie.swift
//  BAZProject
//
//

import Foundation

/// Protocol used to decouple the Movie structure
protocol ListMovieProtocol {
    var id: Int { get set }
    var title: String? { get set }
    var originalTitle: String? { get set }
    var posterPath: String? { get set }
    var isFavorite: Bool? { get set }
    var backdropPath : String? { get set }
    var releaseDate: String?  { get set }
    var overview: String? { get set  }
    var originalLanguage : String? { get set }
    var popularity: Float? { get set }
    var voteAverage: Float? { get set }
    var voteCount: Int? { get set }
    
}

/// Structure that contains the data that will be used in the view
struct Movie: Codable {
    let results: [MovieResult]?
}

// MARK: - Result
struct MovieResult: Codable, ListMovieProtocol {
    var id: Int
    var title: String?
    var originalTitle: String?
    var posterPath: String?
    var isFavorite: Bool? = false
    var backdropPath: String?
    var releaseDate: String?
    var overview: String?
    var originalLanguage: String?
    var popularity: Float?
    var voteAverage: Float?
    var voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, overview, popularity
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case originalLanguage = "original_language"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
