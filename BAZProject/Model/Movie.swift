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
