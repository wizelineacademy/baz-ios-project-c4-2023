//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class MovieAPI {
    
    private var service: Service
    
    init(service: Service = ServiceAPI(session: URLSession.shared)) {
        self.service = service
    }
    ///Función generica que consulta el trending de peliculas
    func getMovies(completion: @escaping ([ListMoviesProtocol], Error?) -> Void){
        guard let url = URL(string: "\(urls.TrendingURL.rawValue)\(urls.apikey.rawValue)") else { return }
        service.get(url) { (result: Result<Movies , Error>) in
            switch result {
            case .success(let apiResults): completion(apiResults.results ?? [], nil)
            case .failure(let error): completion([], error)
            }
        }
    }
}
