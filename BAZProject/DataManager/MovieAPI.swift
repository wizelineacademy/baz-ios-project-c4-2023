//  MovieAPI.swift
//  BAZProject
//
//  Created by jehernandezg

import UIKit

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
        guard let request = endpoint.request else {
            onFinished(.failure(NSError()))
            return
        }

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

