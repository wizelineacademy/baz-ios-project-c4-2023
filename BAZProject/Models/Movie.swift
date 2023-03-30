//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct MovieList: Codable {
    let results: [Movie]
}

struct Movie: Codable {
    let id: Int
    let title: String
    let poster_path: String
}
