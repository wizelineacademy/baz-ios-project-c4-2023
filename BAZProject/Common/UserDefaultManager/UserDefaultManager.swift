//
//  UserDefaultManager.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 12/05/23.
//

import Foundation

protocol UserDefaultsProtocol {
    func data(forKey defaultName: String) -> Data?
    func setValue(_ value: Any?, forKey key: String)
    func returnMoviesDictionary() -> [Int : Movie]?
}

extension UserDefaults: UserDefaultsProtocol {
    func returnMoviesDictionary() -> [Int : Movie]?{
        guard let dataMovie = self.data(forKey: "favorite_movies"),
              let dctMovies: [Int : Movie] = try? JSONDecoder().decode([Int : Movie].self, from: dataMovie) else { return nil}
        return dctMovies
    }
}

protocol UserDefaultManagerProtocol {
    func isFavorite(id: Int) -> Bool
    func saveFavorite(movie:Movie)
    func getFavorite(id: Int) -> Movie?
    func getFavoriteList() -> [Movie]
    func deleteFavorite(_ id: Int)
}

final class UserDefaultManager: UserDefaultManagerProtocol {
    
    let userDefault: UserDefaultsProtocol
    let decoder: JSONDecoder
    let encoder: JSONEncoder
    
    init(userDefault: UserDefaultsProtocol = UserDefaults.standard,
         decoder: JSONDecoder = JSONDecoder(),
         encoder:  JSONEncoder = JSONEncoder()) {
        self.userDefault = userDefault
        self.decoder = decoder
        self.encoder = encoder
    }
    
    func isFavorite(id: Int) -> Bool{
        guard let dctMovies = userDefault.returnMoviesDictionary() else { return false }
        return dctMovies[id] != nil
    }
    
    func getFavorite(id: Int) -> Movie?{
        guard let dctMovies = userDefault.returnMoviesDictionary() else { return nil }
        return dctMovies[id]
    }
    
    func getFavoriteList() -> [Movie]{
        guard let dctMovies = userDefault.returnMoviesDictionary() else { return [] }
        return Array( dctMovies.values )
    }
    
    func saveFavorite(movie: Movie){
        guard let dctMovies: [Int : Movie] = userDefault.returnMoviesDictionary() else { return }
        var movies = dctMovies
        movies[movie.id] = movie
        if let data = try? encoder.encode(movies){
            userDefault.setValue(data, forKey: "favorite_movies")
        }
    }
    
    func deleteFavorite(_ id: Int) {
        guard let dctMovies: [Int : Movie] = userDefault.returnMoviesDictionary() else { return }
        var movies = dctMovies
        movies.removeValue(forKey: id)
        userDefault.setValue(movies, forKey: "favorite_movies")
    }
    
}

