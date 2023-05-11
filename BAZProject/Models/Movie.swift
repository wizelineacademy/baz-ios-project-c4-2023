//
//  Movie.swift
//  BAZProject
//
//

import Foundation

/// MovieList is a Decodable struct that represents a list of movies.
/// It contains an array of Movie objects.
struct MovieList: Codable {
    var results: [Movie]
}

/// Movie is a Decodable struct that represents a single movie.
/// It contains the following properties:
/// - id: An optional integer that represents the movie's unique identifier.
/// - title: An optional string that represents the movie's title.
/// - poster_path: An optional string that represents the movie's poster path.
/// - overview: An optional string that represents overview of the movie's plot.
/// - release_date: An optional string that represents the release date of the movie.
/// - popularity: An optional double that represents the popularity score of the movie.
/// - vote_average: An optional double that represents the average rating score of the movie.
struct Movie: Codable {
    let id: Int
    let title: String?
    let poster_path: String?
    let overview: String?
    let release_date: String?
    let popularity: Double?
    let vote_average: Double?
}
