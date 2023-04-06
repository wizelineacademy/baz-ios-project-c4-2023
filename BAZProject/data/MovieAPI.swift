//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    /// Servicio que consume de la API DB movie
    /// - Parameters:
    ///   - completion: El closure a llamar una vez que se completa la operación.
    ///   El closure toma un parámetro `[Movie]` que devolvera al terminar la peticion.
    func getMovies(completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "\(Consts.END_POINTS.URL)day?api_key=\(Consts.END_POINTS.API_KEY)")
        else {
            return completion([])
        }

        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            var movies: [Movie] = []
            defer {
                completion(movies)
            }
            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
                  let results = json.object(forKey: "results") as? [NSDictionary]
            else { return }

            for result in results {
                if let id = result.object(forKey: "id") as? Int,
                   let title = result.object(forKey: "title") as? String,
                   let poster_path = result.object(forKey: "poster_path") as? String {
                    movies.append(Movie(id: id, title: title, poster_path: poster_path))
                }
            }
        }.resume()
    }
}
