//
//  MoviesDataSourceRemote.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 16/04/23.
//

import Foundation

// MARK: - Class
class MoviesDataSourceRemote: MoviesRepository {

    /**
     Esta funcion implementa el metodo del protocolo MoviesRepository
     Obtiene todas las películas que cumplen con los filtros especificados
     y llama a al closure de finalización como argumento con los objetos Movie correspondientes.

     - Parameter filter: El enum Filters que especifica los filtros para obtener películas.
     - Parameter completion: El closure de finalización que toma una matriz de objetos Movie como argumento de entrada y no devuelve nada.
     */
    func getMovies(filter: Filters, completion: @escaping ([Movie]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let url = self.getUrlFilter(filter).toUrl()

            URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
                var movies: [Movie] = []
                defer {
                    completion(movies)
                }
                guard let data = data else { return }

                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MoviesResponse.self, from: data)
                    movies = response.results
                } catch {
                    print("\(#function) Error decoding JSON: \(error)")
                }
            }.resume()
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
        DispatchQueue.global(qos: .background).async {
            let url = self.getUrlFilter(filter, movieID).toUrl()

            URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
                var movies: [Movie] = []
                defer {
                    completion(movies)
                }
                guard let data = data else { return }

                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(MoviesResponse.self, from: data)
                    movies = response.results
                } catch {
                    print("\(#function) Error decoding JSON: \(error)")
                }
            }.resume()
        }
    }

    /**
     Metodo para retornar el string del EndPoint de las constastes de la capa de dominio
     - Parameter filter: El enum Filters que especifica el EndPoint a usar.
     - Parameter movieID: parametro opcional para complementar el EndPoint
     */
    func getUrlFilter(_ filter: Filters, _ movieID: Int? = nil) -> String {
        switch filter {
        case .trending:
            return Consts.END_POINTS.TRENDING
        case .nowPlaying:
            return Consts.END_POINTS.NOW_PLAYING
        case .popular:
            return Consts.END_POINTS.POPULAR
        case .topRated:
            return Consts.END_POINTS.TOO_RATED
        case .upcoming:
            return Consts.END_POINTS.UPCOMING
        case .similar:
            return Consts.END_POINTS.SIMILAR.setParameters(old: "{movieID}", new: "\(movieID ?? 0)")
        case .recommendations:
            return Consts.END_POINTS.RECOMMENDATIONS.setParameters(old: "{movieID}", new: "\(movieID ?? 0)")
        }
    }
}
