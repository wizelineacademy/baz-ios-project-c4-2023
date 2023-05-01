//
//  ReviewMoviesPresenter.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import Foundation

final class ReviewMoviesPresenter {
    
    // MARK: properties
    weak var view: ReviewMoviesViewInputProtocol?
    var interactor: ReviewMoviesInteractorInputProtocol
    var router: ReviewMoviesRouterProtocol
    
    init(view: ReviewMoviesViewInputProtocol, interactor: ReviewMoviesInteractorInputProtocol, router: ReviewMoviesRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension ReviewMoviesPresenter: ReviewMoviesViewOutputProtocol {
    // Presenter notify to Router Pop a VC
    func popViewController() {
        router.popViewController()
    }
    
    /// Presenter ask to Interactor that want a fecth from API
    /// - parameters:
    ///    - url: a String url fetch
    ///    - key: a String to be searched
    func reviewMovies(idMovie: String) {
        interactor.reviewMovies(idMovie: idMovie)
    }
}

extension ReviewMoviesPresenter: ReviewMoviesInteractorOutputProtocol {
    func presenterReviewMovies(movieReview movie: MovieProtocol) {
        // Presenter return movie Information from the fecth
        view?.showReviewMovies(movie: movie)
    }
}

