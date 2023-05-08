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
    /// comunicacition betwen Presenter and Interactor to delete favourite movies
    func deleteFavouritesMovies() {
        interactor.deleteFavouritesMovies()
    }
    
    // Presenter notify to Router Pop a VC
    func popViewController() {
        router.popViewController()
    }
    
    /// comunicacition betwen Presenter and Interactor to get favourite movies
    func favouriteMovies() {
        interactor.favouriteMovies()
    }
}

extension FavouriteMoviesPresenter: FavouriteMoviesInteractorOutputProtocol {
    func presenterFavouriteMovies(moviesFavourite: [Movie]) {
        // Presenter return Information (favourites movies in storage) from the fecth
        view?.showFavouriteMovies(movies: moviesFavourite)
    }
}

