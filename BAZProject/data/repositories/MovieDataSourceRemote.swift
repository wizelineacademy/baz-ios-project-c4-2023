//
//  MovieDataSourceRemote.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 16/04/23.
//

import Foundation

class MovieDataSourceRemote: MovieRepository {

    // private let movieApi = MovieAPI()

    /**
     Esta funcion implementa el metodo del protocolo MovieRepository
     Obtiene el reparto de la película correspondiente a su id y llama al closure de finalización como argumento con los objetos Actor correspondientes.

     - Parameter movieID: El ID de la película para obtener su reparto.
     - Parameter completion: El closure de finalización que toma una matriz de objetos Actor como argumento de entrada y no devuelve nada.
     */
    func getCast(movieID: Int, completion: @escaping ([Actor]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let url = Consts.END_POINTS.MOVIE_CAST.setParameters(old: "{movieID}", new: "\(movieID)").toUrl()

            URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
                var characters: [Actor] = []
                defer {
                    completion(characters)
                }
                guard let result = data else { return }

                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ActorResponse.self, from: result)
                    characters = response.cast
                } catch {
                    print("\(#function) Error decoding JSON: \(error)")
                }
            }.resume()
        }
    }

    /**
     Esta funcion implementa el metodo del protocolo MovieRepository
     Obtiene los reviews de la película correspondiente a su id y llama al closure de finalización como argumento con los objetos Review correspondientes.

     - Parameter movieID: El ID de la película para obtener sus revisiones.
     - Parameter completion: El closure de finalización que toma una matriz de objetos Review como argumento de entrada y no devuelve nada.
     */
    func getReviews(movieID: Int, completion: @escaping ([Review]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let url = Consts.END_POINTS.MOVIE_REVIEWS.setParameters(old: "{movieID}", new: "\(movieID)").toUrl()

            URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
                var reviews: [Review] = []
                defer {
                    completion(reviews)
                }
                guard let data = data else { return }

                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(ReviewResponse.self, from: data)
                    reviews = response.results
                } catch {
                    print("\(#function) Error decoding JSON: \(error)")
                }
            }.resume()
        }
    }
}
