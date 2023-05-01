//
//  FavoritesViewModel.swift
//  BAZProject
//
//  Created by Manuel S on 01/05/23.
//

import Foundation


class FavoritesViewModel: FavoriteListProtocol {
    
    //MARK: - Outlets
    var favoriteMovies: Box<[InfoMoviesProtocol]>?
    let userDefaults = UserDefaults.standard

    func bindMovie(_ listener: @escaping () -> Void) {
        favoriteMovies?.listener = listener
    }
    
    ///regresa el contador del arreglo de peliculas
    func getMovieCount() -> Int {
        favoriteMovies?.value.count ?? 0
    }
    ///regresa el campo titulo de la pelicula
    func getTitle(index: Int) -> String? {
        favoriteMovies?.value[index].title
    }
    
    func getPathImage(index: Int) -> String? {
        favoriteMovies?.value[index].poster_path
    }
    
    func getAllInfoMoview(index: Int) -> InfoMoviesProtocol {
        favoriteMovies!.value[index]
    }
    
    func getFavoritesMovies(key: String) {
        do {
            if let data = UserDefaults.standard.data(forKey: key) {
                let UDData = try JSONDecoder().decode([Movie].self, from: data)
                favoriteMovies = Box(value: UDData)
            }
        } catch {
            print("Can not store:", error)
        }
        print("se elimino")
    }
}
