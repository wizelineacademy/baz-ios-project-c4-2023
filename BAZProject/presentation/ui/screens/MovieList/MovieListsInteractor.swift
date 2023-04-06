//
//  MovieListsInteractor.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 30/03/23.
//

import Foundation

class MovieListsInteractor: MovieListsInteractorProtocol {

    // MARK: - Variables

    var presenter: MovieListsPresenterProtocol?
    var repository: MovieRepository?

    // MARK: - Protocols Functions

    func getMovies() {
        repository?.getAllMovie { [self] movies in
            self.presenter?.successFetchMovies(movies)
        }
    }
}
