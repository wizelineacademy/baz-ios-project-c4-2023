//
//  HomeInteractor.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import Foundation

// All the validations of query data for show movies or any error
final class HomeInteractor {
    var presenter: HomeInteractorOutputProtocol?
    var movieApi: MovieAPIProtocol
    var movies: [Movie] = []
    var favouriteManager: FavouritesManagerProtocol
    init(movieAPI: MovieAPIProtocol, favouriteManager: FavouritesManagerProtocol) {
            self.movieApi = movieAPI
            self.favouriteManager = favouriteManager
    }
}

extension HomeInteractor: HomeInteractorInputProtocol {
    func storeFav(movieFav: Movie) {
        favouriteManager.registerFav(movieData: movieFav)
    }
    
    func getFavs() -> [Movie] {
        favouriteManager.getFavouriteMovies()
    }
    
    /// This fetch function works for get the movie data from API
    /// - parameters:
    ///    - url: a String url fetch
    ///    - section: section of the table wher we show this information
    func fetchCategories(url: String, section: Int) {
        guard let urlFetch = URL(string: movieApi.basePath + url + movieApi.apiKey) else {
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
