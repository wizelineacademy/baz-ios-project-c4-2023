//
//  FavouritesManager.swift
//  BAZProject
//
//  Created by ksolano on 08/05/23.
//

import Foundation

final class FavouriteManager: FavouritesManagerProtocol {
    let storeUserDefaults: MoviesStorageProtocol? = UserDefaults.standard

    func deleteAllFavorites() {
        do {
            try storeUserDefaults?.delete(forKey: StorageKey.moviesFavourites)
        } catch {
            debugPrint("No pudimos eliminar tus favoritos")
        }
    }
    
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
    
    func getFavouriteMovies() -> [Movie] {
        let movies = try? storeUserDefaults?.get(forKey: StorageKey.moviesFavourites)
        guard let moviesData = movies else {
            print("No se pudo recuperar información")
            return []
        }
        do {
            let movie = try JSONDecoder().decode([Movie].self, from: moviesData)
            print("Favoritas recuperadas: ", movie.count)
            return movie
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func deleteFavorite(idMovie: Int) {
        var movies = getFavouriteMovies()
        if let index = movies.firstIndex(where: { $0.id == idMovie }) {
            movies.remove(at: index)
        }
        setFavorites(favMovies: movies)
    }
}
