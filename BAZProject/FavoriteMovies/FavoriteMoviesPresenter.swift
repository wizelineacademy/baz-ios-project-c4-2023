//
//  FavoriteMoviesPresenter.swift
//  BAZProject
//
//  Created by Carlos Garcia on 04/05/23.
//

import Foundation

class FavoriteMoviesPresenter {
    // MARK: Properties
    weak var view: FavoriteMoviesViewProtocol?
    var interactor: FavoriteMoviesInteractorInputProtocol?
    var router: FavoriteMoviesRouterProtocol?
    
    init(interactor: FavoriteMoviesInteractorInputProtocol,
         router: FavoriteMoviesRouterProtocol,
         movie: MovieInfo? = nil) {
        self.interactor = interactor
        self.router = router
        self.interactor?.presenter = self
    }
    
    // MARK: Functions
}

extension FavoriteMoviesPresenter: FavoriteMoviesPresenterProtocol {
    func viewDidLoad() {
        view?.setNavigationTitle(for: interactor?.getNavTitle())
    }
    
    func attach(view: FavoriteMoviesViewProtocol?) {
        self.view = view
    }
    
    func present() {
        self.router?.present(presenter: self)
    }
    
    func loadMovies() {
        interactor?.loadFavoriteMovies()
    }
    
    func numberOfRows() -> Int? {
        interactor?.getMoviesCount()
    }
    
    func getMovie(for indexPath: IndexPath) -> MovieInfo? {
        interactor?.getMovie(for: indexPath)
    }
    
    func goToMovieDetails(for indexPath: IndexPath) {
        if let movie: MovieInfo = interactor?.getMovie(for: indexPath) {
            router?.goToMovieDetailsView(movie, parent: self.view)
        }
    }
}

extension FavoriteMoviesPresenter: FavoriteMoviesInteractorOutputProtocol {
    func presentMovies() {
        view?.updateMovies()
    }
}
