//
//  SearchDataSourceRemote.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 27/04/23.
//

import Foundation

// MARK: - Class
class SearchDataSourceRemote: SearchRepository {

    /**
     Esta funcion implementa el metodo del protocolo SearchRepository
     Obtiene todas las peliculas relacionadas a la palabra clave que se recibe en la variable query y llama al closure de finalización como argumento con los objetos Movie correspondientes.

     - Parameter query: Palabra clave para buscar las peliculas.
     - Parameter completion: El closure de finalización que toma una matriz de objetos Movie como argumento de entrada y no devuelve nada.
     */
    func searchMovies(query: String, completion: @escaping ([Movie]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let url = Consts.END_POINTS.SEARCH_MOVIES.setParameters(old: "{keyword}", new: query).toUrl()
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
     Esta funcion implementa el metodo del protocolo SearchRepository
     Obtiene todas las peliculas relacionadas a la palabra clave que se recibe en la variable query y llama al closure de finalización como argumento con el arreglo de Strings correspondientes.

     - Parameter query: Palabra clave para buscar cualquier pelicula en base a la palabra clave.
     - Parameter completion: El closure de finalización que toma una matriz de Strings como argumento de entrada y no devuelve nada.
     */
    func searchKeyword(query: String, completion: @escaping ([String]) -> Void) {
        DispatchQueue.global(qos: .background).async {
            let url = Consts.END_POINTS.SEARCH_FOR_KEYWORD.setParameters(old: "{keyword}", new: query).toUrl()
            URLSession.shared.dataTask(with: .init(url: url)) { data, _, _ in
                var keywords: [String] = []
                defer {
                    completion(keywords)
                }
                guard let data = data,
                      let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
                      let results = json.object(forKey: "results") as? [NSDictionary]
                else { return }

                for result in results {
                    if let name = result.object(forKey: "name") as? String {
                        keywords.append(name)
                    }
                }
            }.resume()
        }
    }
}
