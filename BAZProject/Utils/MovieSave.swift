//
//  MovieSave.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 02/05/23.
//

import Foundation

public final class SaveMovies {
    
    enum TypeMovieSave: String {
    case favoriteMovies
    }
    
    private let decoder = JSONDecoder()
    private let encoder = JSONEncoder()
    private let userDefaults = UserDefaults.standard
    
    func save(_ movie: Int, title: TypeMovieSave) throws {
        var data: Data!
        do {
            let dataMovies = try? load(title: title)
            if let idMovies = dataMovies, idMovies.count > 0 {
                var arrayMovies = idMovies
                arrayMovies.append(movie)
                data = try encoder.encode(arrayMovies)
            } else {
                data = try encoder.encode([movie])
            }
        }
        userDefaults.set(data, forKey: title.rawValue)
    }
    
    func load(title: TypeMovieSave) throws -> [Int] {
        guard let data = userDefaults.data(forKey: title.rawValue),
              let movie = try? decoder.decode([Int].self, from: data)
        else {
            throw Error.dataNotFound
        }
        return movie
    }
    
    func delete(title: TypeMovieSave, idMovie: Int) {
        do {
            let arrayMovies = try? load(title: title).filter( { $0 != idMovie } )
            let data = try? encoder.encode(arrayMovies)
            userDefaults.set(data, forKey: title.rawValue)
        }
    }
    
    func isSave(title: TypeMovieSave, idMovie: Int) -> Bool{
        var isSave = false
        do {
            let arrayMovies = try? load(title: title)
            arrayMovies?.forEach({ idMovieSave in
                if idMovieSave == idMovie {
                    isSave = true
                }
            })
        }
        return isSave
    }
    
    public enum Error: String, Swift.Error {
        case dataNotFound
    }
}
