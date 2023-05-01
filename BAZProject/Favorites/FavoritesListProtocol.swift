//
//  FavoritesListProtocol.swift
//  BAZProject
//
//  Created by Manuel S on 01/05/23.
//

import Foundation


protocol FavoriteListProtocol {
    
    var favoriteMovies: Box<[InfoMoviesProtocol]>? { get set }
    func bindMovie(_ listener: @escaping () -> Void)
    func getMovieCount() -> Int
    func getTitle(index: Int) -> String?
    func getPathImage(index: Int) -> String?
    func getFavoritesMovies()
}
