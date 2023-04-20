//
//  MovieAPI.swift
//  BAZProject
//
//

import UIKit

struct MovieAPIConstans {
    static var baseURL = "https://api.themoviedb.org/3/"
    static var trending = "trending/movie/day"
    static var search = "search/movie"
    static var searchKeyWord = "&language=es&page=2&query=Matrix"
    static var apiKey = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    static var baseUrlImage = "https://image.tmdb.org/t/p/w500"
}

final class MovieAPI {
    
    func fetchData<T: Decodable>(model: T.Type, urlPath: String, onFinished: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlPath) else { return }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(model, from: data) {
                    DispatchQueue.main.async {
                        onFinished(.success(decodedResponse))
                    }
                    return
                }
                else {
                    onFinished(.failure(error ?? NSError()))
                }
            }
            onFinished(.failure(error ?? NSError()))
        }.resume()
    }
    
}

