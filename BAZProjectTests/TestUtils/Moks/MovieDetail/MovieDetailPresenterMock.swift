//
//  MovieDetailPresenterMock.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 07/05/23.
//

import Foundation
@testable import BAZProject

enum MovieDetailPresenterCalls{
    case getSimilar
    case getRecomendation
    case getCast
    case getReviews
    case setCast
    case setReviews
    case setSimilarMovies
    
    case setRecomendedMovies
    case setFavorite
    case findFavoriteMovie
    case favoriteMovie
    case sendToReviews
}


final class MovieDetailPresenterMock: MoviewDetailPresenterProtocol{
    var movie: BAZProject.ListMovieProtocol
    
    var calls: [MovieDetailPresenterCalls] = []
    
    weak private var view: MoviewDetailViewProtocol?
    
    var interactor: MoviewDetailInteractorProtocol?
    
    private let router: MoviewDetailWireframeProtocol

    init(movie: BAZProject.ListMovieProtocol, interface: BAZProject.MoviewDetailViewProtocol, interactor: BAZProject.MoviewDetailInteractorProtocol?, router: BAZProject.MoviewDetailWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.movie = movie
    }
    
    func getSimilar() {
        calls.append(.getSimilar)
    }
    
    func getRecomendation() {
        calls.append(.getRecomendation)
    }
    
    func getCast() {
        calls.append(.getCast)
    }
    
    func getReviews() {
        calls.append(.getReviews)
    }
    
    func setCast(_ cast: [BAZProject.Cast]) {
        calls.append(.setCast)
    }
    
    func setReviews(_ reviews: [BAZProject.Review]) {
        calls.append(.setReviews)
    }
    
    func setSimilarMovies(movies: [BAZProject.ListMovieProtocol]) {
        calls.append(.setSimilarMovies)
    }
    
    func setRecomendedMovies(movies: [BAZProject.ListMovieProtocol]) {
        calls.append(.setRecomendedMovies)
    }
    
    func setFavorite(_ isFavorite: Bool) {
        calls.append(.setFavorite)
    }
    
    func findFavoriteMovie() {
        calls.append(.findFavoriteMovie)
    }
    
    func favoriteMovie() {
        calls.append(.favoriteMovie)
    }
    
    func sendToReviews(reviews: [BAZProject.Review]) {
        calls.append(.sendToReviews)
    }

}
