//
//  TrendingViewProtocols.swift
//  BAZProject
//
//  Created by Manuel S on 10/04/23.
//

import Foundation

protocol TrendingListProtocol {
    var movies: Box<[InfoMoviesProtocol]> { get set }
    func getmovies(category: CategoriesFilter) ///se consulta el servicio para lista de peliculas
    func getMovieCount() -> Int ///regresa el contador del arreglo de peliculas
    func getTitle(index: Int) -> String? ///regresa el campo titulo de la pelicula
    func bindMovies(_ listener: @escaping () -> Void) ///Crear bind que llama al listener
    func getPathImage(index: Int) -> String? /// Regresa el path para la consulta de la imagen
    func getAllInfoMoview(index: Int) -> InfoMoviesProtocol /// Regresa la informacion de una pelucula
}
