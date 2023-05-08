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
    
    init(presenter: BAZProject.MoviewDetailPresenterProtocol? = nil, movie: BAZProject.ListMovieProtocol? = nil, similarMovies: [BAZProject.ListMovieProtocol] = [], recomendedMovies: [BAZProject.ListMovieProtocol] = [], cast: [BAZProject.Cast] = [], reviews: [BAZProject.Review] = []) {
        self.presenter = presenter
        self.movie = movie
        self.similarMovies = similarMovies
        self.recomendedMovies = recomendedMovies
        self.cast = cast
        self.reviews = reviews
    }
    
    func setSimilarMovies(movies: [BAZProject.ListMovieProtocol]) {
        calls.append(.setSimilarMovies)
    }
    
    func setRecomendedMovies(movies: [BAZProject.ListMovieProtocol]) {
        calls.append(.setRecomendedMovies)
    }
    
    func setCast(_ cast: [BAZProject.Cast]) {
        calls.append(.setCast)
    }
    
    func setFavorite(_ isFavorite: Bool) {
        calls.append(.setFavorite)
    }
    
    func setReviews(_ reviews: [BAZProject.Review]) {
        calls.append(.setReviews)
    }
    
    
    
}
