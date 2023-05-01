//
//  ReviewMoviesInteractor.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import Foundation

final class ReviewMoviesInteractor {
    var presenter: ReviewMoviesInteractorOutputProtocol?
    let movieApi: MovieAPIProtocol
    var movie: MovieProtocol? = nil
    init(movieAPI: MovieAPIProtocol) {
            self.movieApi = movieAPI
    }
}

extension ReviewMoviesInteractor: ReviewMoviesInteractorInputProtocol {
    /// Fecth for the search movie with a url and a key if this is required
    /// - parameters:
    ///    - url: a String url fetch
    ///    - key: a String to be searched
    func reviewMovies(idMovie: String) {
        presenter?.presenterReviewMovies(movieReview: movie!)
    } 
}
