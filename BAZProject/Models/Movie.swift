//
//  Movie.swift
//  BAZProject
//
//

import Foundation

/**
MovieList is a Decodable struct that represents a list of movies.
It contains an array of Movie objects.
*/
struct MovieList: Decodable {
    let results: [Movie]
}

/**
Movie is a Decodable struct that represents a single movie.

It contains the following properties:

id: An optional integer that represents the movie's unique identifier.
title: An optional string that represents the movie's title.
poster_path: An optional string that represents the movie's poster path.
*/
struct Movie: Decodable {
    let id: Int?
    let title: String?
    let poster_path: String?
}
