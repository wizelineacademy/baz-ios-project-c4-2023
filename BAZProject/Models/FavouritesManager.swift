//
//  FavouritesManager.swift
//  BAZProject
//
//  Created by ksolano on 08/05/23.
//

import Foundation

final class FavouriteManager: FavouritesManagerProtocol {
    
    let storeUserDefaults: MoviesStorageProtocol? = UserDefaults.standard
    
    /// Logic for set and storage the movies
    /// if the user has in favourites the movie selected this movie isn´t save in this time and is deleted
    func registerFav(movieData: Movie) {
        var favMovies : [Movie] = getFavouriteMovies()
        var count: Int = 0
        favMovies.forEach { movie in
            count = movie.id == movieData.id ? count + 1 : count
        }
        if count == 0 {
            favMovies.append(movieData)
            setFavorites(favMovies: favMovies)
        }else {
            deleteFavorite(idMovie: movieData.id ?? 0)
        }
    }
    /// Set values of an specific key of UserDefaults
    /// - parameters: favMovies is an Array of Movies to storage
    func setFavorites(favMovies: [Movie]) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(favMovies) {
            do {
                try storeUserDefaults?.set(encodedData, forKey: StorageKey.moviesFavourites)
            } catch {
                debugPrint("No pudimos agregarlo a tus favoritos")
            }
        }
    }
    ///  Get all favourite movies that the user has in the storage of UserDefaults
    ///  - return: array of Movies
    func getFavouriteMovies() -> [Movie] {
        let movies = try? storeUserDefaults?.get(forKey: StorageKey.moviesFavourites)
        guard let moviesData = movies else {
            debugPrint("No se pudo recuperar información")
            return []
        }
        do {
            let movie = try JSONDecoder().decode([Movie].self, from: moviesData)
            print("Favoritas recuperadas: ", movie.count)
            return movie
        } catch {
            debugPrint(error.localizedDescription)
            return []
        }
    }
    /// Delete some movie of user storage through an id
    /// This func is call when user touch in fav button and the movie is previusly in the stoarge
    func deleteFavorite(idMovie: Int) {
        var movies = getFavouriteMovies()
        if let index = movies.firstIndex(where: { $0.id == idMovie }) {
            movies.remove(at: index)
        }
        setFavorites(favMovies: movies)
    }
    
    /// Delete all the favourites movies that have the user
    func deleteAllFavorites() {
        do {
            try storeUserDefaults?.delete(forKey: StorageKey.moviesFavourites)
        } catch {
            debugPrint("No pudimos eliminar tus favoritos")
        }
    }
}
