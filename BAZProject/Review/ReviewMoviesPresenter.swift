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
    /// Presenter ask to Interactor that want a fecth from API of similar movies
    /// - parameters:
    ///    - url: a Url  to fetch
    func similarMovies(url: String) {
        interactor.similarMovies(url: url)
    }
    
    /// Presenter ask to Interactor that want a fecth from API of recomended movies
    /// - parameters:
    ///    - url: a Url  to fetch
    func recomendedMovies(url: String) {
        interactor.recomendedMovies(url: url)
    }
    
    // Presenter notify to Router Pop a VC
    func popViewController() {
        router.popViewController()
    }
    
    /// Presenter ask to Interactor that want a fecth from API
    /// - parameters:
    ///    - url: a Url  to fetch
    func reviewMovies(url: String) {
        interactor.reviewMovies(url: url)
    }
}

extension ReviewMoviesPresenter: ReviewMoviesInteractorOutputProtocol {
    func presenterSimiliarMovies(similarMovies: [Movie]) {
        // Presenter return similar movies Information from the fecth
        view?.showSimilarMovies(similarMovies: similarMovies)
    }
    
    func presenterRecomendedMovies(recomendedMoviess: [Movie]) {
        // Presenter return recomended movies Information from the fecth
        view?.showRecomendedMovies(recomendedMoviess: recomendedMoviess)
    }
    
    func presenterReviewMovies(movieReview: MovieReview) {
        // Presenter return movie Information from the fecth
        view?.showReviewMovies(movie: movieReview)
    }
}

