//
//  MovieDetailsInteractor.swift
//  BAZProject
//
//  Created by Carlos Garcia on 21/04/23.
//  
//

import Foundation

class MovieDetailsInteractor: MovieDetailsInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: MovieDetailsInteractorOutputProtocol?
    var entity: MovieDetailsEntity?
    var movieAPI: MovieAPI?
    var movie: MovieDetailsInfo?
    
    let storageManager: StorageManagerProtocol
    
    init(presenter: MovieDetailsInteractorOutputProtocol? = nil,
         entity: MovieDetailsEntity? = nil,
         movieAPI: MovieAPI? = nil,
         movie: MovieDetailsInfo? = nil,
         storageManager: StorageManagerProtocol) {
        self.presenter = presenter
        self.entity = entity
        self.movieAPI = movieAPI
        self.movie = movie
        self.storageManager = storageManager
    }

    func getNavTitle() -> String?{
        entity?.strNavBarTitle
    }
    
    func fetchMovieDetails() {
        guard let movieID = entity?.movie.id else { return }
        movieAPI?.searchMovieDetails(for: movieID, completion: {[weak self] movie in
            if let movie = movie {
                self?.movie = movie
                self?.presenter?.presentMovieDetails(self?.movie)
                self?.fetchMovieCredtis()
            } else {
                self?.presenter?.presentMovieCredits(nil)
            }
        })
    }
    
    private func fetchMovieCredtis() {
        guard let movieID = entity?.movie.id else { return }
        movieAPI?.searchMovieCredits(for: movieID, completion: {[weak self] credits in
            self?.movie?.credits = credits
            self?.presenter?.presentMovieCredits(self?.movie?.credits)
        })
    }
    
    func fetchMovieReviews() {
        guard let movieID = entity?.movie.id else { return }
        movieAPI?.searchMovieReviews(for: movieID, completion: {[weak self] (reviews, error)  in
            self?.presenter?.presentMovieReviews(reviews)
        })
    }
    
    func downloadBackdropImage(with path: String) {
        ResourcesManager().downloadImage(from: path) {[weak self] image in
            self?.presenter?.presentMovieBackdropImage(image)
        }
    }
    
    func fetchSimilarMovies() {
        guard let movieID = entity?.movie.id else { return }
        movieAPI?.getSimilarMovies(to: movieID, completion: {[weak self] (movies, error) in
            self?.presenter?.presentSimilarMovies(movies)
        })
    }
    
    func fetchRecommendations() {
        guard let movieID = entity?.movie.id else { return }
        movieAPI?.getRecommendationsMovies(to: movieID, completion: {[weak self] (movies, error) in
            self?.presenter?.presentRecommendations(movies)
        })
    }
    
    func verifyFavorite() {
        guard let movieID = entity?.movie.id else { return }
        if let favoriteMovies: FavoriteMovies = storageManager.retrieve(forKey: .favoriteMovies) {
            presenter?.presentFavoriteMovie(favoriteMovies.containMovie(for: movieID))
        } else {
            print("Movie \(movieID) is not into favorites!")
        }
    }
    
    func saveToFavorites() {
        guard let movie = entity?.movie as? Movie else { return }
        if var favorites: FavoriteMovies = storageManager.retrieve(forKey: .favoriteMovies) {
            favorites.addMovie(movie)
            storageManager.store(favorites, forKey: .favoriteMovies)
            presenter?.presentFavoriteMovie(true)
        } else {
            let favorites = FavoriteMovies(movies: [movie])
            storageManager.store(favorites, forKey: .favoriteMovies)
            presenter?.presentFavoriteMovie(true)
        }
    }
    
    func removeFromFavorites() {
        guard let movieID = entity?.movie.id else { return }
        if var favorites: FavoriteMovies = storageManager.retrieve(forKey: .favoriteMovies) {
            favorites.removeMovie(for: movieID)
            storageManager.store(favorites, forKey: .favoriteMovies)
            presenter?.presentFavoriteMovie(false)
        } else {
            presenter?.presentFavoriteMovie(true)
        }
    }
}
