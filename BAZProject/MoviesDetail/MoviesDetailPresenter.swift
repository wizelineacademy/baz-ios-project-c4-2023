//
//  MoviesDetailPresenter.swift
//  BAZProject
//
//  Created by nmorenoa on 25/04/23.
//

import Foundation
final class MoviesDetailPresenter {
    
    // MARK: Properties
    weak var view       : MoviesDetailViewInputProtocol?
    var interactor      : MoviesDetailInteractorInputProtocol?
    var router          : MoviesDetailRouterProtocol?
    var resultReviews   : [ReviewsMovieData] = []
    var resultRecomendations : [RecomendationsData] = []
    
    init(view: MoviesDetailViewInputProtocol? = nil,
         interactor: MoviesDetailInteractorInputProtocol? = nil,
         router: MoviesDetailRouterProtocol? = nil) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
    }
    
}
// MARK: Extension
extension MoviesDetailPresenter: MoviesDetailViewOutputProtocol{
    
    func consultReviews() {
        view?.setInfoMovie(with: interactor?.moviesInfo)
        interactor?.getReview()
        interactor?.getRecomendations()
    }
    
}
extension MoviesDetailPresenter: MoviesDetailInteractorOutputProtocol{
    
    func setResponseDetailsMovies(with resultReviews: [ReviewsMovieData]) {
        self.resultReviews.removeAll()
        self.resultReviews = resultReviews
        view?.setReviews()
    }
    
    func setResponseRecomendations(with result: [RecomendationsData]) {
        self.resultRecomendations.removeAll()
        self.resultRecomendations = result
        view?.setRecomendations()
    }
    
    func setError() {
        print("error...")
    }
    
    
}
