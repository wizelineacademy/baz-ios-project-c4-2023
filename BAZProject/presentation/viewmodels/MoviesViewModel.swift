//
//  MoviesViewModel.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 16/04/23.
//

import Foundation

// MARK: - Class
class MoviesViewModel {

    // MARK: - public variables
    var movies: [Movie] = []
    var onMoviesUpdate: (() -> Void)?

    // MARK: - private variables
    private let repository: MoviesRepository

    init(_ repository: MoviesRepository) {
        self.repository = repository
    }

    // MARK: - public functions
    func fetchMovies(_ filter: Filters) {
        repository.getMovies(filter: filter) { movies in
            self.movies = movies
            self.onMoviesUpdate?()
        }
    }

    func fetchRelatedMovies(_ filter: Filters, _ movieID: Int) {
        repository.getRelatedMovies(filter: filter, movieID: movieID) { movies in
            self.movies = movies
            self.onMoviesUpdate?()
        }
    }
}
