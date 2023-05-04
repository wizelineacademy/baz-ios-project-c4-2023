//
//  SearchListProtocol.swift
//  BAZProject
//
//  Created by Manuel S on 01/05/23.
//

import Foundation


protocol SearchListProtocol {
    
    var moviesSearched: Box<[InfoMoviesProtocol]> { get set } ///Varible donde se almacenara informacion de las peliculas

    //MARK: - Funciones para la vista
    func bindMovies(_ listener: @escaping () -> Void) ///Crear bind que llama al listener
    func getMovieCount() -> Int ///regresa el contador del arreglo de peliculas
    func getTitle(index: Int) -> String? ///regresa el campo titulo de la pelicula
    func cleanMoviesArray() ///Limpia el arreglo para otra consulta
    func getImagePath(index: Int) -> String? ///regresa el campo del path para la imagen de la pelicula
    func getAllInfoMoview(index: Int) -> InfoMoviesProtocol ///Funcion que devolvera la informacion de una pelicula
    func searchMovie(_ title: String, apiKey: String, completion: @escaping (Error?) -> Void) ///se consulta el servicio para lista de peliculas
}
