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

///Clase mock de MovieDetailPresenter

final class MovieDetailPresenterMock: MoviewDetailPresenterProtocol{
    
    ///Movie  con que se inicializa MovieDetailPresenterMock
    var movie: BAZProject.ListMovieProtocol
    
    ///Array de enum de las llamadas a los metodos que contien el MovieDetailPresenterMock
    var calls: [MovieDetailPresenterCalls] = []
    
    ///view  que contien el MovieDetailPresenterMock
    weak private var view: MoviewDetailViewProtocol?
    
    ///Interactor  que contien el MovieDetailPresenterMock
    var interactor: MoviewDetailInteractorProtocol?
    
    ///router  que contien el MovieDetailPresenterMock
    private let router: MoviewDetailWireframeProtocol
    
    
    ///incializador de  MovieDetailPresenterMock
    /// - parameters:
    ///    - movie: Movie  con que se inicializa MovieDetailPresenterMock
    ///    - interface: view  que contien el MovieDetailPresenterMock
    ///    - interactor:Interactor  que contien el MovieDetailPresenterMock
    ///    - router: router  que contien el MovieDetailPresenterMock
    init(movie: BAZProject.ListMovieProtocol, interface: BAZProject.MoviewDetailViewProtocol, interactor: BAZProject.MoviewDetailInteractorProtocol?, router: BAZProject.MoviewDetailWireframeProtocol) {
        self.view = interface
        self.interactor = interactor
        self.router = router
        self.movie = movie
    }
    
    ///metodo que llama getSimilar del presenter
    func getSimilar() {
        calls.append(.getSimilar)
    }
    
    ///metodo que llama getRecomendation del presenter
    func getRecomendation() {
        calls.append(.getRecomendation)
    }
    
    ///metodo que llama getCast del presenter
    func getCast() {
        calls.append(.getCast)
    }
    
    ///metodo que llama getReviews del presenter
    func getReviews() {
        calls.append(.getReviews)
    }
    
    ///rmetodo que llama setCast del presenter
    func setCast(_ cast: [BAZProject.Cast]) {
        calls.append(.setCast)
    }
    
    ///metodo que llama setReviews del presenter
    func setReviews(_ reviews: [BAZProject.Review]) {
        calls.append(.setReviews)
    }
    
    ///metodo que llama setSimilarMovies del presenter
    func setSimilarMovies(movies: [BAZProject.ListMovieProtocol]) {
        calls.append(.setSimilarMovies)
    }
    
    ///metodo que llama setRecomendedMovies del presenter
    func setRecomendedMovies(movies: [BAZProject.ListMovieProtocol]) {
        calls.append(.setRecomendedMovies)
    }
    
    ///metodo que llama setFavorite del presenter
    func setFavorite(_ isFavorite: Bool) {
        calls.append(.setFavorite)
    }
    
    ///metodo que llama isFavorite del presenter
    func isFavorite() {
        calls.append(.findFavoriteMovie)
    }
    
    ///metodo que llama favoriteMovie del presenter
    func favoriteMovie() {
        calls.append(.favoriteMovie)
    }
    
    ///metodo que llama sendToReviews del presenter
    func sendToReviews(reviews: [BAZProject.Review]) {
        calls.append(.sendToReviews)
    }

}
