//
//  MoviesViewModel.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 16/04/23.
//

import Foundation

class MoviesViewModel {
    
    var movies: [Movie] = []
    var onMoviesUpdate: (() -> Void)?
    
    private let repository: MoviesRepository
    
    init(_ repository: MoviesRepository) {
        self.repository = repository
    }
    
    func fetchMovies(_ filter: Filters) {
        repository.getAllMovie(filter: filter) { movies in
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
