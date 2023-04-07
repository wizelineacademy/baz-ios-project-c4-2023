//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    func getMovies(completion: @escaping ([MovieInfo]?) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(APIConfig.accessKey)")
        else {
            return completion([])
        }
        
        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            guard let data = data,
                  let response = try? JSONDecoder().decode(ServiceResponse<[Movie]>.self, from: data),
                  let arrMovies = response.result
            else {
                completion(nil)
                return
            }
            completion(arrMovies)
        }.resume()
    }

}
