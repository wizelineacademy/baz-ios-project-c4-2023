//
//  SearchDataSourceRemote.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 27/04/23.
//

import Foundation

// MARK: - Class
class SearchDataSourceRemote: SearchRepository {

    private let movieApi = MovieAPI()

    /**
     Esta funcion implementa el metodo del protocolo SearchRepository
     Obtiene todas las peliculas relacionadas a la palabra clave que se recibe en la variable query y llama al closure de finalización como argumento con los objetos Movie correspondientes.

     - Parameter query: Palabra clave para buscar las peliculas.
     - Parameter completion: El closure de finalización que toma una matriz de objetos Movie como argumento de entrada y no devuelve nada.
     */
    func searchMovies(query: String, completion: @escaping ([Movie]) -> Void) {
        movieApi.searchMoviesForKeyword(query) { movies in
            completion(movies)
        }
    }

    /**
     Esta funcion implementa el metodo del protocolo SearchRepository
     Obtiene todas las peliculas relacionadas a la palabra clave que se recibe en la variable query y llama al closure de finalización como argumento con los objetos Movie correspondientes.

     - Parameter query: Palabra clave para buscar cualquier pelicula en base a la palabra clave.
     - Parameter completion: El closure de finalización que toma una matriz de objetos Movie como argumento de entrada y no devuelve nada.
     */
    func searchKeyword(query: String, completion: @escaping ([String]) -> Void) {
        movieApi.searchForKeyword(query) { keywords in
            completion(keywords)
        }
    }
}
