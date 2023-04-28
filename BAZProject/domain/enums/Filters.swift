//
//  Filters.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 30/03/23.
//

import Foundation

/// Diferentes tipos de categorias en las peliculas
/// al usar la API DB Movie
enum Filters {
    case trending
    case nowPlaying
    case popular
    case topRated
    case upcoming
    case similar
    case recommendations
}
