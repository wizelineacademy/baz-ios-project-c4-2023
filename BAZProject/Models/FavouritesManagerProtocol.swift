//
//  FavouritesManagerProtocol.swift
//  BAZProject
//
//  Created by ksolano on 08/05/23.
//

import Foundation

protocol FavouritesManagerProtocol {
    func registerFav (movieData: Movie)
    func setFavorites(favMovies: [Movie])
    func getFavouriteMovies() -> [Movie]
    func deleteAllFavorites()
}
