//
//  MovieResult.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 12/04/23.
//

import Foundation

struct MoviesResult: Decodable {
    let title: String?
    let PosterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case PosterPath = "poster_path"
    }
}
