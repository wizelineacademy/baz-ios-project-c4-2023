//
//  MovieAPI.swift
//  BAZProject
//
//

import UIKit

struct MovieAPIConstans {
    // MARK: - Constants
    static let apiKey = "?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    static let baseURL = "https://api.themoviedb.org/3/"
    static let trending = "trending/movie/day\(apiKey)"
    static let search = "search/movie\(apiKey)\(searchConfig)"
    static let searchConfig = "&language=es&page=1&query="
    static let baseUrlImage = "https://image.tmdb.org/t/p/w500"
}

enum Endpoint {
    static var baseURL = MovieAPIConstans.baseURL
    case trending
    case search(query: String)
}

extension Endpoint {
    var stringURL: String {
        switch self {
        case .trending:
            return MovieAPIConstans.trending
        case .search(query: let query):
            return "\(MovieAPIConstans.search)\(query.replacingOccurrences(of: " ", with: "%20"))"
        }
    }
    
    var request : URLRequest? {
        let pathURL = URL(string: "\(Endpoint.baseURL)\(stringURL)") ?? URL(fileURLWithPath: "")
        var request = URLRequest(url: pathURL)
        request.httpMethod = "GET"
        return request
    }
}


final class MovieAPI {
    /**
     Function that gets an array of movies from url
     - Parameters:
        - model: The model for decode
        - urlPath: The url path from Json
        - onFinished: The result of service
     - Version: 1.0.0
    */
    func fetchData<T: Decodable>(model: T.Type, _ endpoint: Endpoint, onFinished: @escaping (Result<T, Error>) -> Void) {
        guard let request = endpoint.request else { return }

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
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

