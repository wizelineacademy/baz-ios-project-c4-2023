//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    /**
     Get trending movies for day.
     
     The completion handler takes the following parameters:
     
     - Parameters:
        - arrMovies: Return an array of  type`MovieInfo` protocol.
     */
    func getMovies(completion: @escaping (_ arrMovies: [MovieInfo]?) -> Void) {
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(APIConfig.accessKey)")
        else {
            return completion([])
        }
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
                guard let data = data,
                      let response = try? JSONDecoder().decode(ServiceResponse<[Movie]>.self, from: data),
                      let arrMovies = response.result
                else {
                    DispatchQueue.main.async(execute: {
                        completion(nil)
                    })
                    return
                }
                DispatchQueue.main.async(execute: {
                    completion(arrMovies)
                })
            }.resume()
        }
    }

}
