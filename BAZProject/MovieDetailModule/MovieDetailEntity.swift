//
//  MovieDetailEntity.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 27/04/23.
//

import Foundation

import Foundation

struct MovieDetail: Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case status
    }
}
