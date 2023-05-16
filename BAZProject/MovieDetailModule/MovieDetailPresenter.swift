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
    var isFavorite: Bool = false
    var movieId: Int
    
    init(movieId: Int) {
        self.movieId = movieId
    }
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    func saveFavoriteMovie() {
        let movieId: Int? = movieDetail?.id
        interactor?.saveFavoriteMovie(of: movieId)
    }
    
    func deleteToFavoriteMovie() {
        let movieId: Int? = movieDetail?.id
        interactor?.deleteToFavoriteMovie(of: movieId)
    }
    
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
