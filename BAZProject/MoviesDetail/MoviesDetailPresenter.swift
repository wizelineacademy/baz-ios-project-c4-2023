//
//  MoviesDetailPresenter.swift
//  BAZProject
//
//  Created by nmorenoa on 25/04/23.
//

import Foundation
final class MoviesDetailPresenter {
    
    // MARK: - Properties
    weak var view       : MoviesDetailViewInputProtocol?
    var interactor      : MoviesDetailInteractorInputProtocol?
    var router          : MoviesDetailRouterProtocol?
    var resultReviews           : [ReviewsMovieData]    = []
    var resultRecomendations    : [InfoDetailData]      = []
    var resultSimilars          : [InfoDetailData]      = []
    
    init(view: MoviesDetailViewInputProtocol? = nil,
         interactor: MoviesDetailInteractorInputProtocol? = nil,
         router: MoviesDetailRouterProtocol? = nil) {
        self.view       = view
        self.interactor = interactor
        self.router     = router
    }
    
}
// MARK: - Extension
extension MoviesDetailPresenter: MoviesDetailViewOutputProtocol{
    
    func viewDidLoad() {
        view?.setInfoMovie(with: interactor?.moviesInfo)
        interactor?.getInfo(detail: .Reviews)
        interactor?.getInfo(detail: .Recomendations)
        interactor?.getInfo(detail: .Similars)
    }
    
    func getInfoFavoritesMovies() {
        if let getFavoriteMovies = interactor?.getFavoriteMovies(){
            interactor?.bIsFavorite = getFavoriteMovies
            view?.setBtnLike(bsIsOn: getFavoriteMovies)
        }
    }
    
    func addMovieToFavorite() {
        if interactor?.bIsFavorite ?? false{
            interactor?.removeFavoriteMovies()
        }else{
            interactor?.addFavoriteMovies()
        }
    }
    
}
extension MoviesDetailPresenter: MoviesDetailInteractorOutputProtocol{
    
    func setResponseDetailsMovies(with resultReviews: [ReviewsMovieData]) {
        self.resultReviews.removeAll()
        self.resultReviews = resultReviews
        view?.setReviews()
    }
    
    func setResponseDetail(with result: [InfoDetailData], detail typeDetail: OptionDetail?) {
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
    
    func showBtnFavorites(with bIsOn: Bool?) {
        view?.setBtnLike(bsIsOn: bIsOn ?? false)
    }
    
    func setError() {
        router?.presentAlert(CWAlert.simpleWith(message: "No se encontraron resultados"))
    }
    
}
