//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    /**
     Servicio que consume de la API DB movie
     - Parameter query: Palabra a consultar
     - Parameter completion: El closure a llamar una vez que se completa la operación.
                             El closure toma un parámetro `[Movie]` que devolvera al terminar la peticion.
     */
    func searchMoviesForKeyword(_ query: String, completion: @escaping ([Movie]) -> Void) {
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

    /**
     Servicio que consume de la API DB movie
     - Parameter query: Palabra a consultar
     - Parameter completion: El closure a llamar una vez que se completa la operación.
                             El closure toma un parámetro `[Movie]` que devolvera al terminar la peticion.
     */
    func searchForKeyword(_ query: String, completion: @escaping ([String]) -> Void) {
        let url = Consts.END_POINTS.SEARCH_FOR_KEYWORD.setParameters(old: "{keyword}", new: query).toUrl()
        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
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

    /**
     Metodo generico para consumir peticiones
     */
    func request<T: Decodable>(url: URL, completion: @escaping ([T]) -> Void) {
        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            var items: [T] = []
            defer {
                completion(items)
            }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            guard let results = try? decoder.decode([T].self, from: data) else { return }
            items = results
        }.resume()
    }
}
