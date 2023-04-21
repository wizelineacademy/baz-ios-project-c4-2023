//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

final class MovieAPI: GenericAPI {
    
    func fetch<T>(request: URLRequest, completionHandler: @escaping (Result<T?, Error>) -> Void) where T : Decodable {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                completionHandler(.failure(ApiError.defaultError))
                return
            }
            if let decodedResponse: T = self.decode(data: data) {
                DispatchQueue.main.async {
                    completionHandler(.success(decodedResponse))
                }
                return
            }
        }.resume()
    }
}
