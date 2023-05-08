//
//  DetailPresenter.swift
//  BAZProject
//
//  Created by jehernandezg on 03/05/23.
//

import UIKit

// MARK: - Class
class DetailPresenter {
    // MARK: - Properties
    weak var view: DetailViewInputProtocol?
    var interactor: DetailInteractorInputProtocol
    var router: DetailRouterProtocol
    var detailMovie: ListMovieProtocol
    
    init(view: DetailViewInputProtocol,
         interactor: DetailInteractorInputProtocol,
         router: DetailRouterProtocol,
         detailMovie: ListMovieProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.detailMovie = detailMovie
    }
}

// MARK: - Extensions

// MARK: - V I E W · T O · P R E S E N T E R
extension DetailPresenter: DetailViewOutputProtocol {
    // MARK: - Functions
    func getDetailMovie() {
        interactor.getDetailMovie(detailMoviePI: self.detailMovie)
    }
    
    func getMovies(endPoint: Endpoint) {
        interactor.getMovies(endPoint: endPoint) {}
    }
    
    func getRecomendations(endPoint: Endpoint) {
        interactor.getRecomendations(endPoint: endPoint) {}
    }
    
    func getMovieImage(imagePath: String, completion: @escaping (UIImage?) -> Void) {
        interactor.getMovieImage(imagePath: imagePath, completion: completion)
    }
}

// MARK: - I N T E R A C T O R · T O · P R E S E N T E R
extension DetailPresenter: DetailInteractorOutputProtocol {
    // MARK: - Functions
    func presentDetailMovie(detailMovie: ListMovieProtocol) {
        view?.showDetailMovie(detailMovie: detailMovie)
    }
    
    func presentMovies(movies: [ListMovieProtocol]?) {
        view?.showMovies(movies: movies)
    }
    
    func presentRecomendations(movies: [ListMovieProtocol]?) {
        view?.showRecomendations(movies: movies)
    }
}
