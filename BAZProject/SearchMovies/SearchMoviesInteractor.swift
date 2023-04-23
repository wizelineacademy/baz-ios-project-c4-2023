//
//  SearchMoviesInteractor.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import Foundation

final class SearchMoviesInteractor {
    var presenter: SearchMoviesInteractorOutputProtocol?
    let basePath: String = "https://api.themoviedb.org/3/"
    let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    let movieApi = MovieAPI()
    var movies: [MovieProtocol] = []
}

extension SearchMoviesInteractor: SearchMoviesInteractorInputProtocol {
    // Fecth for the search movie with a url and a key if this is required
    func searchMovies(url: String, key: String) {
        guard let urlFetch = URL(string: basePath + url + apiKey + key) else {
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
                    self.presenter?.presenterSearchMovies(movies: self.movies)
                }
            }
        }
    } 
}
