//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"

    func getMovies(url: String, completion: @escaping ([Movie]?) -> ()) {
        guard let url = URL(string: "\(url)?api_key=\(apiKey)")
        else {
            return completion([])
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {

                let movieList = try? JSONDecoder().decode(MovieList.self, from: data)

                if let movieList = movieList {
                    completion(movieList.results)
                }
                
                print(movieList?.results)
            }
        }.resume()
    }

}
