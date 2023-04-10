//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

final class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"

    // Function that get movies from themoviedb API and return it in a completion of type [MovieProtocol]
    func getMovies(completion: @escaping ([MovieProtocol]) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)")
        else {
            return completion([])
        }
        
        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            var movies: [MovieProtocol] = []
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
                   let poster_path = result.object(forKey: "poster_path") as? String{
                    movies.append(Movie(id: id, title: title, poster_path: poster_path))
                }
            }
        }.resume()
    }
}
