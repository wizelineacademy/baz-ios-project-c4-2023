//
//  FavoriteSavingManager.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 12/05/23.
//

import Foundation

public class FavoriteSavingManager {
    private var persistence: PersistenceProtocol?
    
    public init(persistence: PersistenceProtocol? = nil) {
        self.persistence = persistence
    }
    
    public func handle(movie movieToHandle: Movie?, isFavorite bIsFavorite: Bool) {
        guard let movie = movieToHandle else { return }
        bIsFavorite ? persistence?.delete(info: movie) : persistence?.save(info: movie)
    }
    
    public func movieIsFavorite(_ movie: Movie?) -> Bool {
        guard let movie = movie, let arrFavorites: [Movie] = persistence?.getAll(), !arrFavorites.isEmpty else { return false }
        let filteredArray = arrFavorites.filter { movieInArray in
            return movie.id == movieInArray.id
        }
        return !filteredArray.isEmpty
    }
}
