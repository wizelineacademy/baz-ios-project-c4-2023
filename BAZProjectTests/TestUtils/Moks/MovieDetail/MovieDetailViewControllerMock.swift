//
//  MovieDetailViewController.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 07/05/23.
//

import Foundation
@testable import BAZProject

enum MovieDetailViewControllerCalls{
    case setSimilarMovies
    case setRecomendedMovies
    case setCast
    case setFavorite
    case setReviews

}


final class MovieDetailViewconrollerMock: MoviewDetailViewProtocol{
    var calls: [MovieDetailViewControllerCalls] = []
    var presenter: BAZProject.MoviewDetailPresenterProtocol?
    var movie: BAZProject.ListMovieProtocol?
    var similarMovies: [BAZProject.ListMovieProtocol] = []
    var recomendedMovies: [BAZProject.ListMovieProtocol] = []
    var cast: [BAZProject.Cast] = []
    var reviews: [BAZProject.Review] = []
    
    ///incializador de  MovieDetailViewconrollerMock
    /// - parameters:
    ///    - presenter: presneter  con que se inicializa MovieDetailPresenterMock
    ///    - movie: movie  que contien el MovieDetailPresenterMock
    ///    - similarMovies:similarMovies  que contien el MovieDetailPresenterMock
    ///    - recomendedMovies: recomendedMovies  que contien el MovieDetailPresenterMock
    ///    - cast: cast  que contien el MovieDetailPresenterMock
    ///    - reviews: reviews  que contien el MovieDetailPresenterMock
    
    init(presenter: BAZProject.MoviewDetailPresenterProtocol? = nil, movie: BAZProject.ListMovieProtocol? = nil, similarMovies: [BAZProject.ListMovieProtocol] = [], recomendedMovies: [BAZProject.ListMovieProtocol] = [], cast: [BAZProject.Cast] = [], reviews: [BAZProject.Review] = []) {
        self.presenter = presenter
        self.movie = movie
        self.similarMovies = similarMovies
        self.recomendedMovies = recomendedMovies
        self.cast = cast
        self.reviews = reviews
    }
    
    ///metodo que llama setSimilarMovies del view
    func setSimilarMovies(movies: [BAZProject.ListMovieProtocol]) {
        calls.append(.setSimilarMovies)
    }
    
    ///metodo que llama setRecomendedMovies del view
    func setRecomendedMovies(movies: [BAZProject.ListMovieProtocol]) {
        calls.append(.setRecomendedMovies)
    }
    
    ///metodo que llama setCast del view
    func setCast(_ cast: [BAZProject.Cast]) {
        calls.append(.setCast)
    }
    
    ///metodo que llama setFavorite del view
    func setFavorite(_ isFavorite: Bool) {
        calls.append(.setFavorite)
    }
    
    ///metodo que llama setReviews del view
    func setReviews(_ reviews: [BAZProject.Review]) {
        calls.append(.setReviews)
    }
    
    
    
}
