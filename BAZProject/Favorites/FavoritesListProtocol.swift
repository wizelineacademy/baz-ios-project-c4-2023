//
//  FavoritesListProtocol.swift
//  BAZProject
//
//  Created by Manuel S on 01/05/23.
//

import Foundation

protocol FavoriteListProtocol {
    var favoriteMovies: Box<[InfoMoviesProtocol]>? { get set }
    func bindMovie(_ listener: @escaping () -> Void) ///Funcion que setea el bind para el box
    func getMovieCount() -> Int ///regresa el contador del arreglo de peliculas
    func getTitle(index: Int) -> String? ///regresa el campo titulo de la pelicula
    func getPathImage(index: Int) -> String? ///Regresa el path para la consulta de la imagen
    func getFavoritesMovies(key: String) //Funcion para poder obtener info de UserDefaults
    func getAllInfoMoview(index: Int) -> InfoMoviesProtocol? ///Regresa la informacion de la pelicula
}
