//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

enum NetworkError: Error {
    case badURL
    case emptyResult
    case badNetwork
    // Indentifiers of error for cases in Fecth
    var localizedDescription: String {
        switch self {
        case .badURL:
            return "Error en la URL"
        case .emptyResult:
            return "No hay resultado"
        case .badNetwork:
            return "Revisa tu conexión"
        }
    }
}

final class MovieAPI: MovieAPIProtocol {
    var apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    var basePath: String = "https://api.themoviedb.org/3/"
    /// Generic function that get movies from themoviedb API and return a completion Result<T,NetworkError>
    /// - Parameters:
    ///  - urlRequest:  URL API
    func fetch<T: Decodable>(urlRequest: URLRequest,completion: @escaping (Result<T,NetworkError>) -> Void) {
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let data = data,
                  let result: T = self.decode(data: data)
            else {
                completion(.failure(.emptyResult))
                return
            }
            completion(.success(result))
        }.resume()
    }
    
    // Decode data of API receiving a data and default has a JSONDecoder
    func decode<T: Decodable>(data: Data, jsonDecoder: JSONDecoder = JSONDecoder()) -> T? {
        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch (let error as NSError) {
            debugPrint("Error: \(error.debugDescription)")
        }
        return nil
    }
    
    
}
