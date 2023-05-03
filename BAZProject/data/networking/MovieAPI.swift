//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    /**
     Metodo generico para consumir peticiones
     */
    func request<T: Decodable>(url: URL, completion: @escaping ([T]) -> Void) {
        URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            var items: [T] = []
            defer {
                completion(items)
            }
            guard let data = data else { return }
            let decoder = JSONDecoder()
            guard let results = try? decoder.decode([T].self, from: data) else { return }
            items = results
        }.resume()
    }
}
