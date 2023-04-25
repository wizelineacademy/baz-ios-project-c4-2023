//
//  Movie.swift
//  BAZProject
//
//

import Foundation

//MARK: - Protocolos y datos para peliculas

protocol ListMoviesProtocol {
    var id: Int? { get set }
    var title: String? { get set }
    var poster_path: String? { get set }
}
// Estructura para parsear las peliculas
struct Movie: Decodable, ListMoviesProtocol {
    var id: Int?
    var title: String?
    var poster_path: String?
}

struct Movies: Decodable {
    var results: [Movie]?
}
