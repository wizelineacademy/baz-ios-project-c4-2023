//
//  HomeInteractor.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import Foundation

// All the validations of query data for show movies or any error
class HomeInteractor {
    var presenter: HomeInteractorOutputProtocol?
    let basePath: String = "https://api.themoviedb.org/3/"
    let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    let movieApi = MovieAPI()
    var movies: [MovieProtocol] = []
}

extension HomeInteractor: HomeInteractorInputProtocol {
    
    // This fetch function works for get the movie data from API
    func fetchCategories(url: String, section: Int) {
        guard let urlFetch = URL(string: basePath + url + apiKey) else {
            return
        }
        let urlRequestMovie = URLRequest(url: urlFetch)
        movieApi.fetch(urlRequest: urlRequestMovie) { (result: Result<MovieResult, NetworkError>) in
            switch result {
            case .failure(let error):
                debugPrint("Error: \(error.localizedDescription)")
            case .success(let movies):
                self.movies = movies.results
                DispatchQueue.main.async {
                    self.presenter?.presenterCategories(movies: self.movies, section: section)
                }
            }
        }
    }
    
    
}
