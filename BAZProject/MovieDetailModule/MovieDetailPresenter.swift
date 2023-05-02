//
//  MovieDetailPresenter.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 27/04/23.
//  
//


import Foundation

class MovieDetailPresenter {
    var view: MovieDetailViewProtocol?
    var interactor: MovieDetailInteractorInputProtocol?
    var router: MovieDetailRouterProtocol?
    var movieDetail: MovieDetail?
    var movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
    }
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    func notifyViewLoaded() {
        self.interactor?.fetchMovieDetail(of: movieId)
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    func movieDetailFetched(with movieDetail: MovieDetail) {
        self.movieDetail = movieDetail
        self.view?.reloadData()
    }
}
