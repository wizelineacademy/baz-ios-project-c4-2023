//
//  UpcomingPresenter.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import UIKit

class UpcomingPresenter {
    
    // MARK: Properties
    weak var view: UpcomingViewProtocol?
    var interactor: UpcomingInteractorInputProtocol?
    var router: UpcomingRouterProtocol?
    var movies: [Movie]?
    
}

extension UpcomingPresenter: UpcomingPresenterProtocol {
    func notifyViewLoaded() {
        self.interactor?.fetchMovies()
    }
}

extension UpcomingPresenter: UpcomingInteractorOutputProtocol {
    
    /// Función para traer resultado de movies
    /// - Parameter movies: struct movie con id, title y  posterPath
    func moviesFetched(movies: [Movie]) {
        self.movies = movies
        self.view?.reloadData()
    }
}
