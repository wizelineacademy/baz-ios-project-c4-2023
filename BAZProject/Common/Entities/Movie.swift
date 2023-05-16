//
//  Movie.swift
//  BAZProject
//
//

import Foundation

/// Protocolo que desacopla la estructura de Movies
protocol ListMovieProtocol {
    var id: Int { get set }
    var idString: String{ get }
    var title: String { get set }
    var posterPath: String { get set }
    var urlImage: URL? { get }
    var adult: Bool { get set }
    var backdropPath: String? { get set }
    var genreIDS: [Int] { get set }
    var originalLanguage: String { get set }
    var originalTitle: String { get set }
    var overview: String { get set }
    var popularity: Double { get set }
    var releaseDate: String { get set }
    var video: Bool { get set }
    var voteAverage: Double { get set }
    var voteCount: Int { get set }
    var urlBackdropImage: URL? { get }
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
struct Movie: Codable, Equatable, ListMovieProtocol {
    ///Identificador de una pelicula
    var id: Int
    ///Drescripcion del titulo de una pelicula
    var title: String
    ///Path en donde se encuentra la imagen del poster de una pelicula
    var posterPath: String
    ///Boleano para identificar si una pelicula solo para adutos
    var adult: Bool
    ///Path de la imagen cover de la pelicula
    var backdropPath: String?
    ///Array de los identificadores del genero de la pelicula
    var genreIDS: [Int]
    ///Identificador del lenguaje de la pelicula
    var originalLanguage: String
    /// Titlulo original de la pelicula
    var originalTitle: String
    /// Reseña de la pelicula
    var overview: String
    ///Popularidad de la pelicula
    var popularity: Double
    ///String de la fecha de estreno
    var releaseDate: String
    ///Boleano que indica si tiene triler
    var video: Bool
    ///Rating de votos
    var voteAverage: Double
    ///Numero de votos
    var voteCount: Int
    ///URL del poster de la pelicula
    var urlImage: URL?{
        return MovieDetailInfo.image(posterPath).imageUrl
    }
    var urlBackdropImage: URL?{
        return  MovieDetailInfo.image(backdropPath ?? "").imageUrl
    }
    var idString: String{
        return String(id)
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
