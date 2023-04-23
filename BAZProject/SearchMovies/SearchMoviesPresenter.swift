//
//  SearchMoviesPresenter.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import Foundation

final class SearchMoviesPresenter {
    
    // MARK: properties
    weak var view: SearchMoviesViewInputProtocol?
    var interactor: SearchMoviesInteractorInputProtocol
    var router: SearchMoviesRouterProtocol
    
    init(view: SearchMoviesViewInputProtocol, interactor: SearchMoviesInteractorInputProtocol, router: SearchMoviesRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension SearchMoviesPresenter: SearchMoviesViewOutputProtocol {
    // Presenter notify to Router Pop a VC
    func popViewController() {
        router.popViewController()
    }
    // Presenter ask to Interactor that want a fecth from API
    func searchMovies(url: String, key: String) {
        interactor.searchMovies(url: url, key: key)
    }
}

extension SearchMoviesPresenter: SearchMoviesInteractorOutputProtocol {
    func presenterSearchMovies(movies: [MovieProtocol]) {
        // Presenter return movie Informetion from the fecth
        view?.showSearchMovies(movies: movies)
    }
}

