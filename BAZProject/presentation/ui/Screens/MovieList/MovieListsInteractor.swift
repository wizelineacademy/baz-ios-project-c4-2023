//
//  MovieListsInteractor.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 30/03/23.
//

import Foundation

class MovieListsInteractor: MovieListsInteractorProtocol {

    var presenter: MovieListsPresenterProtocol?
    var repository: MovieRepository?

    func getMovies() {
        repository?.getAllMovie { [self] movies in
            self.presenter?.successFetchMovies(movies)
        }
    }
}
