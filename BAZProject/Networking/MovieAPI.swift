//
//  MovieAPI.swift
//  BAZProject
//
//  Created by jmgarciaca on 30/03/23.
//

import Foundation

/**
 Represents a resource with a URL and a parse function that converts data to a generic type T.

 Parameters:
 url: The URL of the resource.
 parse: A function that converts the data from the resource to a generic type T.
*/
struct Resource<T> {
    let url: URL?
    let parse: (Data) -> T?
}

final class MovieAPI {
    /**
      Loading a resource and parsing it into a generic type T.
    */
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> ()) {
        
        guard let url =  resource.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                     completion(resource.parse(data))
                }
            }
        }.resume()
    }
}
