//
//  DetailPresenter.swift
//  BAZProject
//
//  Created by jehernandezg on 03/05/23.
//

import UIKit

// MARK: - Class
class DetailPresenter {
    // MARK: - Properties
    weak var view: DetailViewInputProtocol?
    var interactor: DetailInteractorInputProtocol
    var router: DetailRouterProtocol
    var detailMovie: ListMovieProtocol
    
    init(view: DetailViewInputProtocol,
         interactor: DetailInteractorInputProtocol,
         router: DetailRouterProtocol,
         detailMovie: ListMovieProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.detailMovie = detailMovie
    }
    
}

// MARK: - Extensions

// MARK: - V I E W · T O · P R E S E N T E R
extension DetailPresenter: DetailViewOutputProtocol {
    func getDetailMovie() {
        interactor.getDetailMovie(detailMoviePI: self.detailMovie)
    }
    
//    func getMovieSearch(endPoint: Endpoint) {
//        self.router.showAnimation {
//            self.pEndpoint = endPoint
//            self.interactor.getMovieSearch(endPoint: self.pEndpoint) {
//                self.router.hideAnimation {}
//            }
//        }
//    }
//
//    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void) {
//        interactor.getMovieImage(index: index, completion: completion)
//    }
//
//    func saveFavorite(index: Int) {
//        interactor.saveFavorite(index: index) {
//            self.getMovieSearch(endPoint: self.pEndpoint)
//        }
//    }
//
//    func deleteFavorite(index: Int) {
//        interactor.deleteFavorite(index: index) {
//            self.getMovieSearch(endPoint: self.pEndpoint)
//        }
//    }
}

// MARK: - I N T E R A C T O R · T O · P R E S E N T E R
extension DetailPresenter: DetailInteractorOutputProtocol {
    func presentDetailMovie(detailMovie: ListMovieProtocol) {
        view?.showDetailMovie(detailMovie: detailMovie)
    }
    
//    func getDetailMovie() {
//        interactor.getDetailMovie(detailMoviePI: self.detailMovie)
//    }
    
//    func presentDataMovies(movies: [ListMovieProtocol]?) {
//        view?.showViewDataMovies(movies: movies)
//    }
    
}

