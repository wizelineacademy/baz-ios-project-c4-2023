//
//  FavoriteMoviesInteractor.swift
//  BAZProject
//
//  Created by Carlos Garcia on 04/05/23.
//

import Foundation

class FavoriteMoviesInteractor: FavoriteMoviesInteractorInputProtocol {
    
    // MARK: Properties
    var presenter: FavoriteMoviesInteractorOutputProtocol?
    var entity: FavoriteMoviesEntity?
    var movies: [MovieInfo]?
    var movieAPI: MovieAPI?
    
    let storageManager: StorageManagerProtocol
    
    init(presenter: FavoriteMoviesInteractorOutputProtocol? = nil,
         entity: FavoriteMoviesEntity? = nil,
         movieAPI: MovieAPI? = nil,
         storageManager: StorageManagerProtocol) {
        self.presenter = presenter
        self.entity = entity
        self.movieAPI = movieAPI
        self.storageManager = storageManager
    }
    
    func getNavTitle() -> String? {
        entity?.strNavBarTitle
    }
    
    func loadFavoriteMovies() {
        if let favorites: FavoriteMovies = storageManager.retrieve(forKey: .favoriteMovies) {
            self.movies = favorites.movies
            presenter?.presentMovies()
        } else {
            print("Favorite movies is empty!")
        }
    }
    
    func getMovie(for indexPath: IndexPath) -> MovieInfo? {
        movies?[safe: indexPath.row]
    }
    
    func getMoviesCount() -> Int? {
        movies?.count
    }
}
