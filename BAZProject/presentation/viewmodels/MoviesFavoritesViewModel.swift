//
//  MoviesFavoritesViewModel.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 08/05/23.
//

import Foundation
import CoreData
import UIKit

class MoviesFavoritesViewModel {
    
    // MARK: - public variables
    var movies: [MovieFavorite] = []
    var onMoviesUpdate: (() -> Void)?
    var isMovieFavorite: Bool? = false

    // MARK: - private variables
    var contextDB = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // MARK: - public functions
    func fetchMoviesFavorites() {
        let query: NSFetchRequest<MovieFavorite> = MovieFavorite.fetchRequest()
        do {
            self.movies = try contextDB.fetch(query)
            self.onMoviesUpdate?()
        } catch {
            print(error.localizedDescription)
        }
    }

    func addMovieToFavorites(_ movie: Movie) {
        let addFavorite = MovieFavorite(context: self.contextDB)
        addFavorite.id = Int64(movie.id)
        addFavorite.posterPath = movie.posterPath
        addFavorite.title = movie.title
        addFavorite.voteAverage = movie.voteAverage
        addFavorite.releaseDate = movie.releaseDate
        addFavorite.overview = movie.overview
        do {
            try contextDB.save()
            isMovieFavorite = true
        } catch {
            isMovieFavorite = false
        }
    }
    
    func removeMovieFavorite(_ movieID: Int) {
        let query: NSFetchRequest<MovieFavorite> = MovieFavorite.fetchRequest()
        query.predicate = NSPredicate(format: "id == %@", argumentArray: [movieID])
        do {
            let resultados = try contextDB.fetch(query)
            if let movieDelete = resultados.first {
                contextDB.delete(movieDelete)
                try contextDB.save()
            } else {
                print("No se encontró ninguna pelicula con el ID \(movieID)")
            }
        } catch {
            print("Error al ejecutar la consulta: \(error)")
        }
    }
    
    func setupMovieFavorite(_ movieID: Int) {
        let query: NSFetchRequest<MovieFavorite> = MovieFavorite.fetchRequest()
        query.predicate = NSPredicate(format: "id == %@", argumentArray: [movieID])
        do {
            let resultados = try contextDB.fetch(query)
            if let _ = resultados.first {
                isMovieFavorite = true
            } else {
                isMovieFavorite = false
            }
        } catch {
            isMovieFavorite = false
        }
    }
}
