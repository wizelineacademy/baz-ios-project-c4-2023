//
//  RecentPresenter.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import UIKit

class RecentPresenter {
    
    // MARK: Properties
    weak var view: RecentViewProtocol?
    var interactor: RecentInteractorInputProtocol?
    var router: RecentRouterProtocol?
    var movies: [Movie]?
    
}

extension RecentPresenter: RecentPresenterProtocol {
    func notifyViewLoaded() {
        self.interactor?.fetchMovies()
    }
}

extension RecentPresenter: RecentInteractorOutputProtocol {
    func moviesFetched(movies: [Movie]) {
        self.movies = movies
        self.view?.reloadData()
    }
}

