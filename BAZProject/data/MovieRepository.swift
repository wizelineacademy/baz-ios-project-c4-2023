//
//  MovieRepository.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 30/03/23.
//

import Foundation

// MARK: - Protocol
protocol MovieRepository {
    func getAllMovie(completion: @escaping ([Movie]) -> Void)
}

// MARK: - Implementation of Protocol
class MovieDataSourceRemote: MovieRepository {

    /// Esta funcion implementa el metodo del protocolo MovieRepository
    /// realiza una operación asíncrona y llama al closure proporcionado una vez que se completa.
    ///
    /// - Parameters:
    ///   - completion: El closure a llamar una vez que se completa la operación.
    ///   El closure toma un parámetro `[Movie]` que devolvera al terminar la peticion.
    func getAllMovie(completion: @escaping ([Movie]) -> Void) {
        let movieApi = MovieAPI()
        movieApi.getMovies { movies in
            completion(movies)
        }
    }
}
