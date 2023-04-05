//
//  MovieAPI.swift
//  BAZProject
//
//

import UIKit

struct MovieAPIConstans {
    static var baseURL = "https://api.themoviedb.org/3/"
    static var trending = "trending/movie/day"
    static var apiKey = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    static var baseUrlImage = "https://image.tmdb.org/t/p/w500"
}

final class MovieAPI {

    func getMovies(completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "\(MovieAPIConstans.baseURL)\(MovieAPIConstans.trending)\(MovieAPIConstans.apiKey)")
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
                   let posterPath = result.object(forKey: "poster_path") as? String {
                    movies.append(Movie(id: id, title: title, posterPath: posterPath))
                }
            }
        }.resume()
    }
    
    func getMoviesNew(completion: @escaping ([Movie]) -> Void) {
        guard let url = URL(string: "\(MovieAPIConstans.baseURL)\(MovieAPIConstans.trending)\(MovieAPIConstans.apiKey)")
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
                   let posterPath = result.object(forKey: "poster_path") as? String {
                    movies.append(Movie(id: id, title: title, posterPath: posterPath))
                }
            }
        }.resume()
    }
}

