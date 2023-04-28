//
//  MovieDataSourceRemote.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 16/04/23.
//

import Foundation

class MovieDataSourceRemote: MovieRepository {

    private let movieApi = MovieAPI()

    /**
     Esta funcion implementa el metodo del protocolo MovieRepository
     Obtiene el reparto de la película correspondiente a su id y llama al closure de finalización como argumento con los objetos Actor correspondientes.

     - Parameter movieID: El ID de la película para obtener su reparto.
     - Parameter completion: El closure de finalización que toma una matriz de objetos Actor como argumento de entrada y no devuelve nada.
     */
    func getCast(movieID: Int, completion: @escaping ([Actor]) -> Void) {
        DispatchQueue.global().async {
            self.movieApi.getCastForMovie(movieID: movieID) { characters in
                completion(characters)
            }
        }
    }

    /**
     Esta funcion implementa el metodo del protocolo MovieRepository
     Obtiene los reviews de la película correspondiente a su id y llama al closure de finalización como argumento con los objetos Review correspondientes.

     - Parameter movieID: El ID de la película para obtener sus revisiones.
     - Parameter completion: El closure de finalización que toma una matriz de objetos Review como argumento de entrada y no devuelve nada.
     */
    func getReviews(movieID: Int, completion: @escaping ([Review]) -> Void) {
        DispatchQueue.global().async {
            self.movieApi.getReviewsForMovie(movieID: movieID) { reviews in
                completion(reviews)
            }
        }
    }
}
