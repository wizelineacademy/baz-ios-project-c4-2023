//
//  File.swift
//  BAZProject
//
//  Created by bvelazquezva on 30/03/23.
//

import Foundation

protocol MovieDataProvider {
    func getMovies(completion: @escaping ([Movie]) -> Void)
}

// Clase que maneja la lógica para obtener datos de películas a través de internet
class MovieApi: MovieDataProvider {
    
    func getMovies(completion handler: @escaping ([Movie]) -> Void) {
        let session = URLSession.shared
        let coordinator = GeneralTaskCoordinator(session: session)
        coordinator.urlPath = "trending/movie/day"
                
        coordinator.get{(result: Result<TrendingMovieResult, Error>) in
            switch result {
                case .success(let trendingMovies):
                handler(trendingMovies.results)
                case .failure(let error):
                print(error.localizedDescription.description)
            }
        }
    }
}
