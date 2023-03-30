//
//  MovieListsPresenter.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 30/03/23.
//

import Foundation

class MovieListsPresenter: MovieListsPresenterProtocol {

    var view: MovieListsViewProtocol?
    var interactor: MovieListsInteractorProtocol?

    init(interface: MovieListsViewProtocol, interactor:MovieListsInteractorProtocol) {
        self.view = interface
        self.interactor = interactor
    }

    func loadMovies() {
        interactor?.getMovies()
    }

    func successFetchMovies(_ movies: [Movie]) {
        view?.showMovies(movies)
    }
}
