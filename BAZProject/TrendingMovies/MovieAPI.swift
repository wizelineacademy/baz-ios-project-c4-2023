//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {

    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a" // llave para peticion de peliculas
    ///Función generica que consulta el trending de peliculas
    func getMovies(completion: @escaping ([ListMoviesProtocol]) -> Void){
        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(apiKey)") else { return }
        let service = ServiceAPI(session: URLSession.shared)
        service.get(url) { (result: Result<Movies , Error>) in
            switch result {
            case .success(let apiResults): completion(apiResults.results ?? [])
            case .failure(let error): return
            }
        }
    }
}
