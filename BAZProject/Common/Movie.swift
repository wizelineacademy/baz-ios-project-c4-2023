//
//  Movie.swift
//  BAZProject
//
//

import Foundation

/// Protocolo que desacopla la estructura de Movies
protocol ListMovieProtocol {
    var id: Int { get set }
    var title: String { get set }
    var posterPath: String { get set }
    var urlImage: URL? { get }
}

/// Estructura que contine la información que se usara en la vista
struct MovieResult: Codable {
    ///Arreglo de peliculas
    let results: [Movie]?
    enum CodingKeys: String, CodingKey {
        case results
    }
}

/// Estructura de una pelicula
struct Movie: Codable, ListMovieProtocol {
    ///Identificador de una pelicula
    var id: Int
    ///Drescripcion del titulo de una pelicula
    var title: String
    ///Path en donde se encuentra la imagen del poster de una pelicula 
    var posterPath: String
    ///URL del poster de la pelicula
    var urlImage: URL?{
        return URL(string: ApiConstans.baseUrlImage + posterPath)
    }

    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
    }
    

}
