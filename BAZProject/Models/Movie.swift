//
//  Movie.swift
//  BAZProject
//
//

import Foundation

//MARK: - Protocolos y datos para peliculas

// protocolo para el manejo de peliculas
protocol InfoMoviesProtocol: Codable {
    var id: Int? { get set }
    var title: String? { get set }
    var poster_path: String? { get set } 
    var overview: String? { get set }
    var vote_average: Double? { get set }

}
// Estructura para parsear las peliculas
struct Movie: InfoMoviesProtocol {
    var id: Int?
    var title: String?
    var poster_path: String?
    var overview: String?
    var vote_average: Double?
}

struct Movies: Decodable {
    var results: [Movie]?
}
