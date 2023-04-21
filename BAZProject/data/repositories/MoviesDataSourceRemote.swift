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

    /// Esta funcion implementa el metodo del protocolo MovieRepository
    /// realiza una operación asíncrona y llama al closure proporcionado una vez que se completa.
    ///
    /// - Parameters:
    ///   - completion: El closure a llamar una vez que se completa la operación.
    ///   El closure toma un parámetro `[Movie]` que devolvera al terminar la peticion.
    func getAllMovie(filter: Filters, completion: @escaping ([Movie]) -> Void) {
        DispatchQueue.global().async {
            self.movieApi.getMovies(filter: filter) { movies in
                completion(movies)
            }
        }
    }

    ///
    func getRelatedMovies(filter: Filters, movieID: Int, completion: @escaping ([Movie]) -> Void) {
        DispatchQueue.global().async {
            self.movieApi.getRelatedMovies(filter: filter, movieID: movieID) { movies in
                completion(movies)
            }
        }
    }
}
