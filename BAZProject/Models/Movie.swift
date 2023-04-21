//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct MovieList: Decodable {
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int?
    let title: String?
    let poster_path: String?
}
