//
//  MoviesDataSourceRemote.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 16/04/23.
//

import Foundation

// MARK: - Class
class MoviesDataSourceRemote: MoviesRepository {

    private let movieApi = MovieAPI()

    /**
     Esta funcion implementa el metodo del protocolo MoviesRepository
     Obtiene todas las películas que cumplen con los filtros especificados
     y llama a al closure de finalización como argumento con los objetos Movie correspondientes.

     - Parameter filter: El enum Filters que especifica los filtros para obtener películas.
     - Parameter completion: El closure de finalización que toma una matriz de objetos Movie como argumento de entrada y no devuelve nada.
     */
    func getAllMovie(filter: Filters, completion: @escaping ([Movie]) -> Void) {
        DispatchQueue.global().async {
            self.movieApi.getMovies(filter: filter) { movies in
                completion(movies)
            }
        }
    }

    /**
     Esta funcion implementa el metodo del protocolo MoviesRepository
     Obtiene películas relacionadas con una película correspondiente a su id  y llama a la clausura de finalización como argumento con los objetos Movie correspondientes.

     - Parameter filter: El enum Filters que especifica los filtros para obtener películas relacionadas.
     - Parameter movieID: El ID de la película para obtener sus películas relacionadas.
     - Parameter completion: El closure de finalización que toma una matriz de objetos Movie como argumento de entrada y no devuelve nada.
     */
    func getRelatedMovies(filter: Filters, movieID: Int, completion: @escaping ([Movie]) -> Void) {
        DispatchQueue.global().async {
            self.movieApi.getRelatedMovies(filter: filter, movieID: movieID) { movies in
                completion(movies)
            }
        }
    }
}
