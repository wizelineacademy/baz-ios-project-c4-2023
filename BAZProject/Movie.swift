//
//  Movie.swift
//  BAZProject
//
//

import Foundation

/// Protocol used to decouple the Movie structure
protocol ListMovieProtocol {
    var id: Int { get set }
    var title: String { get set }
    var posterPath: String { get set }
}

/// Structure that contains the data that will be used in the view
struct Movie: Codable {
    let results: [MovieResult]?

    enum CodingKeys: String, CodingKey {
        case results
    }
}

// MARK: - Result
struct MovieResult: Codable, ListMovieProtocol {
    var id: Int
    var title: String
    var posterPath: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
    }
}
