//
//  TrendingPresenter.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 08/04/23.
//  
//

import UIKit

class TrendingPresenter {
    
    // MARK: Properties
    weak var view: TrendingViewProtocol?
    var interactor: TrendingInteractorInputProtocol?
    var router: TrendingRouterProtocol?
    var movies: [Movie]?
    
}

extension TrendingPresenter: TrendingPresenterProtocol {
    func notifyViewLoaded() {
        self.interactor?.fetchMovies()
    }
}

extension TrendingPresenter: TrendingInteractorOutputProtocol {
    /// Función para traer resultado de movies
    /// - Parameter movies: struct movie con id, title y  posterPath
    /// 
    func moviesFetched(movies: [Movie]) {
        self.movies = movies
        self.view?.reloadData()
    }
}
