//
//  DetailsViewProtocols.swift
//  BAZProject
//
//  Created by Manuel S on 27/04/23.
//

import Foundation
import CoreLocation

protocol DetailsProtocol {
    // Variables para guardar las peliculas
    var movieDetail: Box<InfoMoviesProtocol> { get set }
    var recommendationMovies: Box<[InfoMoviesProtocol]> { get set }
    var similarMovies: Box<[InfoMoviesProtocol]> { get set }
    var castMovie: Box<[CastInfoProtocol]> { get set }
    
    //Funciones vista principal
    func getTitle() -> String? ///regresa el campo titulo de la pelicula
    func bindMovie(_ listener: @escaping () -> Void)///Crear bind que llama al listener
    func getPathImage() -> String? /// Regresa el path para la consulta de la imagen
    func getOverview() -> String? ///regresa la reseña de la  peliculas
    func getRating() -> String? ///regresa el rankinf de la  peliculas
    func saveUserDefautls(key: String) /// Salva la pelicula en UserDefauls de favoritos
    func deteleUserDefautls(key: String) /// Elimina la pelicula en UserDefauls de favoritos/
    func isMovieFavorite() -> Bool /// Indicaror si la pelicula esta en el arreglo de favoritos
    ///
    // Funciones para Recomendaciones
    func getRecommendationMovies() ///Consulta el servicio para obtener los datos
    func getRecommendationMoviesTitle(index: Int) -> String? ///regresa el campo titulo de la pelicula
    func getRecommendationMoviesCount() -> Int? ///Regresa el conteo del arreglo de peliculas
    func getRecommendationPath(index: Int) -> String? /// Regresa el path para la consulta de la imagen
    
    // Funciones para Similares
    func getSimilarMovies() ///Consulta el servicio para obtener los datos
    func getSimilarMoviesTitle(index: Int) -> String? ///regresa el campo titulo de la pelicula
    func getSimilarMoviesCount() -> Int? ///Regresa el conteo del arreglo de peliculas
    func getSimilarPath(index: Int) -> String? /// Regresa el path para la consulta de la imagen
    
    // Funciones para Cast
    func getCastMovie() ///Consulta el servicio para obtener los datos
    func getCastMovieTitle(index: Int) -> String?  ///regresa el campo titulo de la pelicula
    func getCastMovieMoviesCount() -> Int?    ///Regresa el conteo del arreglo de peliculas
    func getCastMovieMoviesCharacter(index: Int) -> String?
    func getCastPath(index: Int) -> String? /// Regresa el path para la consulta de la imagen    
}
