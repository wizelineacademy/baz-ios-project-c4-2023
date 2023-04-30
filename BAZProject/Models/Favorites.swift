//
//  Favorites.swift
//  BAZProject
//
//  Created by Manuel S on 29/04/23.
//

import Foundation

// estructura para el guardado de favoritos
struct FavoriteMovie: Codable, InfoMoviesProtocol {
    var id: Int?
    var title: String?
    var poster_path: String?
    var overview: String?
    var vote_average: Double?
}
