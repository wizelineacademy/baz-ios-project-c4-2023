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
    /// Delete allFavouriteMovies in storage of UserDefaults
    func deleteFavouritesMovies() {
        favouriteManager.deleteAllFavorites()
        favouriteMovies()
    }
    
    /// Fecth favourites movies storage in UserDefaults
    func favouriteMovies() {
        presenter?.presenterFavouriteMovies(moviesFavourite: favouriteManager.getFavouriteMovies())
    } 
}
