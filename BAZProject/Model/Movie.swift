//
//  Movie.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 03/04/23.
//

import Foundation

struct Movie: Decodable {
    public var movies: [MoviesResult]?
    
    enum CodingKeys: String, CodingKey {
        case movies = "results"
    }
}

struct MoviesResult: Decodable {
    let title: String?
    let PosterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case PosterPath = "poster_path"
    }
}
