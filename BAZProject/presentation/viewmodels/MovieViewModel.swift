//
//  MovieViewModel.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 16/04/23.
//

import Foundation

class MovieViewModel {
    
    let movie: Movie
    
    var characters: [Actor] = []
    var onCharactersUpdate: (() -> Void)?
    
    var reviews: [Review] = []
    var onReviewsUpdate: (() -> Void)?
    
    private let repository: MovieRepository
    
    init(movie: Movie, repository: MovieRepository) {
        self.movie = movie
        self.repository = repository
    }
    
    func fetchCharacters() {
        repository.getCast(movieID: movie.id) { characters in
            self.characters = characters
            self.onCharactersUpdate?()
        }
    }
    
    func fetchReviews() {
        repository.getReviews(movieID: movie.id) { reviews in
            self.reviews = reviews
            self.onReviewsUpdate?()
        }
    }
}