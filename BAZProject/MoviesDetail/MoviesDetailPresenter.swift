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
    
    /// This function calls the interactor to show if it is favorite and set to the view
    func getInfoFavoritesMovies() {
        if let getFavoriteMovies = interactor?.getFavoriteMovies(){
            interactor?.bIsFavorite = getFavoriteMovies
            view?.setBtnLike(bsIsOn: getFavoriteMovies)
        }
    }
    
    /// This function calls the interactor to remove or add a movie to favorites
    func addMovieToFavorite() {
        if interactor?.bIsFavorite ?? false{
            interactor?.removeFavoriteMovies()
        }else{
            interactor?.addFavoriteMovies()
        }
    }
    
}
extension MoviesDetailPresenter: MoviesDetailInteractorOutputProtocol{
    
    /// This function obtains the result 'Review' of the service to show it in the view
    func setResponseDetailsMovies(with resultReviews: [ReviewsMovieData]) {
        self.resultReviews.removeAll()
        self.resultReviews = resultReviews
        view?.setReviews()
    }
    
    /// This function obtains the result 'Recomendation and Similars' of the service to show it in the view
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
    
    ///calls an alert to display a message
    func setError() {
        router?.presentAlert(CWAlert.simpleWith(message: "No se encontraron resultados"))
    }
    
}
