//
//  SearchMoviesInteractor.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import Foundation

final class SearchMoviesInteractor {
    var presenter: SearchMoviesInteractorOutputProtocol?
    let movieApi: MovieAPIProtocol
    var movies: [Movie] = []
    init(movieAPI: MovieAPIProtocol) {
            self.movieApi = movieAPI
    }
}

extension SearchMoviesInteractor: SearchMoviesInteractorInputProtocol {
    /// Fecth for the search movie with a url and a key if this is required
    /// - parameters:
    ///    - url: a String url fetch
    ///    - key: a String to be searched
    func searchMovies(url: String, key: String) {
        guard let urlFetch = URL(string: movieApi.basePath + url + movieApi.apiKey + key) else {
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
