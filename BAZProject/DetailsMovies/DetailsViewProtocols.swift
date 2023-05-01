//
//  DetailsViewProtocols.swift
//  BAZProject
//
//  Created by Manuel S on 27/04/23.
//

import Foundation


protocol DetailsProtocol {
    // Variables para guardar las peliculas
    var movieDetail: Box<InfoMoviesProtocol> { get set }
    var recommendationMovies: Box<[InfoMoviesProtocol]> { get set }
    var similarMovies: Box<[InfoMoviesProtocol]> { get set }
    var castMovie: Box<[CastInfoProtocol]> { get set }
    
    //Funciones vista principal
    func getTitle() -> String?
    func bindMovie(_ listener: @escaping () -> Void)
    func getPathImage() -> String?
    func getOverview() -> String?
    func getRating() -> String?
    func saveUserDefautls()
    func deteleUserDefautls()
    func isMovieFavorite() -> Bool

    // Funciones para Recomendaciones
    func getRecommendationMovies()
    func getRecommendationMoviesTitle(index: Int) -> String?
    func getRecommendationMoviesCount() -> Int?
    func getRecommendationPath(index: Int) -> String?


    // Funciones para Similares
    func getSimilarMovies()
    func getSimilarMoviesTitle(index: Int) -> String?
    func getSimilarMoviesCount() -> Int?
    func getSimilarPath(index: Int) -> String?
    
    // Funciones para Cast
    func getCastMovie()
    func getCastMovieTitle(index: Int) -> String?
    func getCastMovieMoviesCount() -> Int?
    func getCastMovieMoviesCharacter(index: Int) -> String?
    func getCastPath(index: Int) -> String?
}
