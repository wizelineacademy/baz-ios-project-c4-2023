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
    var resultReviews           : [ReviewsMovieData]    = []
    var resultRecomendations    : [RecomendationsData]  = []
    var resultSimilars          : [RecomendationsData]  = []
    
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
        interactor?.getSimilars()
    }
    
}
extension MoviesDetailPresenter: MoviesDetailInteractorOutputProtocol{
    
    func setResponseDetailsMovies(with resultReviews: [ReviewsMovieData]) {
        self.resultReviews.removeAll()
        self.resultReviews = resultReviews
        view?.setReviews()
    }
    
    func setResponseDetail(with result: [RecomendationsData], detail typeDetail: OptionDetail?) {
        switch typeDetail {
        case .Recomendations:
            self.resultRecomendations.removeAll()
            self.resultRecomendations = result
            view?.setRecomendations()
        case .Similars:
            self.resultSimilars.removeAll()
            self.resultSimilars = result
            view?.setSimilars()
        default: break;
        }
        
    }
    
    func setError() {
        print("error...")
    }
    
}
