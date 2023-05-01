//
//  FavouriteMoviesPresenter.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import Foundation

final class FavouriteMoviesPresenter {
    
    // MARK: properties
    weak var view: FavouriteMoviesViewInputProtocol?
    var interactor: FavouriteMoviesInteractorInputProtocol
    var router: FavouriteMoviesRouterProtocol
    
    init(view: FavouriteMoviesViewInputProtocol, interactor: FavouriteMoviesInteractorInputProtocol, router: FavouriteMoviesRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension FavouriteMoviesPresenter: FavouriteMoviesViewOutputProtocol {
    // Presenter notify to Router Pop a VC
    func popViewController() {
        router.popViewController()
    }
    
    /// Presenter ask to Interactor that want a fecth from API
    /// - parameters:
    ///    - url: a String url fetch
    ///    - key: a String to be searched
    func FavouriteMovies(idMovie: String) {
        interactor.FavouriteMovies(idMovie: idMovie)
    }
}

extension FavouriteMoviesPresenter: FavouriteMoviesInteractorOutputProtocol {
    func presenterFavouriteMovies(movieFavourite movie: MovieProtocol) {
        // Presenter return movie Information from the fecth
        view?.showFavouriteMovies(movie: movie)
    }
}

