//
//  TopRatedPresenter.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 08/04/23.
//  
//

import UIKit

class TopRatedPresenter  {
    
    // MARK: Properties
    weak var view: TopRatedViewProtocol?
    var interactor: TopRatedInteractorInputProtocol?
    var router: TopRatedRouterProtocol?
    var movies: [Movie]?
    
}

extension TopRatedPresenter: TopRatedPresenterProtocol {
    func notifyViewLoaded() {
        self.interactor?.fetchMovies()
    }
}

extension TopRatedPresenter: TopRatedInteractorOutputProtocol {
    func moviesFetched(movies: [Movie]) {
        self.movies = movies
        self.view?.reloadData()
    }
}
