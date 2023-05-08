//
//  FavouriteMoviesInteractor.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import Foundation

final class FavouriteMoviesInteractor {
    var presenter: FavouriteMoviesInteractorOutputProtocol?
    let movieApi: MovieAPIProtocol
    var movies: [Movie]? = nil
    var favouriteManager: FavouritesManagerProtocol
    init(movieAPI: MovieAPIProtocol, favouriteManager: FavouritesManagerProtocol) {
        self.movieApi = movieAPI
        self.favouriteManager = favouriteManager
    }
}

extension FavouriteMoviesInteractor: FavouriteMoviesInteractorInputProtocol {    
    func deleteFavouritesMovies() {
        favouriteManager.deleteAllFavorites()
        favouriteMovies()
    }
    
    /// Fecth for the search movie with a url and a key if this is required
    /// - parameters:
    ///    - url: a String url fetch
    ///    - key: a String to be searched
    func favouriteMovies() {
        presenter?.presenterFavouriteMovies(moviesFavourite: favouriteManager.getFavouriteMovies())
    } 
}
