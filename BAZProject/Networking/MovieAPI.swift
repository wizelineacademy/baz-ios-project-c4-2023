//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

final class MovieAPI {
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        URLSession.shared.dataTask(with: resource.url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                     completion(resource.parse(data))
                }
            }
        }.resume()
    }
}
