//
//  MoviePresenter.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import UIKit

class MoviePresenter {
    
    // MARK: Properties
    weak var view: MovieViewProtocol?
    var interactor: MovieInteractorInputProtocol?
    var router: MovieRouterProtocol?
    var movies: [Movie]?
    
}

extension MoviePresenter: MoviePresenterProtocol {
    func notifyViewLoaded() {
        self.interactor?.fetchMovies()
    }
    
    func goToMovieDetail(of indexPath: IndexPath,from view: UIViewController) {
        if let movieID = self.movies?[indexPath.row].id {
            self.router?.goToMovieDetail(of: movieID, from: view)
        }
    }
}

extension MoviePresenter: MovieInteractorOutputProtocol {
    
    /// Función para traer resultado de movies
    /// - Parameter movies: struct movie con id, title y  posterPath
    func moviesFetched(movies: [Movie]) {
        self.movies = movies
        self.view?.reloadData()
    }
}
