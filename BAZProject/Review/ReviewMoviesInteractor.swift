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
    var movie: MovieReview? = nil
    var similarMovies: [Movie]?
    var recomendedMovies: [Movie]?
    var urlPath: URLRequest?
    init(movieAPI: MovieAPIProtocol) {
            self.movieApi = movieAPI
    }
}

extension ReviewMoviesInteractor: ReviewMoviesInteractorInputProtocol {
    /// Fetch for the get review movie
    /// - parameters:
    ///    - url: a String url fetch
    func reviewMovies(url: String) {
        guard let urlPath = getURL(url: url) else {
            return
        }
        movieApi.fetch(urlRequest: urlPath) { (result: Result<MovieReviewResults, NetworkError>) in
            switch result {
            case .failure(let error):
                debugPrint("Error Review: \(error.localizedDescription)")
            case .success(let movies):
                self.movie = movies.results?.first
                DispatchQueue.main.async {
                    guard let movieReview = self.movie else {
                        return
                    }
                    self.presenter?.presenterReviewMovies(movieReview: movieReview)
                }
            }
        }
    }
    /// Fetch for the get similar movies
    /// - parameters:
    ///    - url: a String url fetch
    func similarMovies(url: String) {
        guard let urlPath = getURL(url: url) else {
            self.presenter?.presenterSimiliarMovies(similarMovies: [])
            return
        }
        movieApi.fetch(urlRequest: urlPath) { (result: Result<MovieResult, NetworkError>) in
            switch result {
            case .failure(let error):
                debugPrint("Error Similar: \(error.localizedDescription)")
            case .success(let movies):
                self.similarMovies = movies.results
                DispatchQueue.main.async {
                    guard let moviesRecomended = self.similarMovies else {
                        self.presenter?.presenterSimiliarMovies(similarMovies: [])
                        return
                    }
                    self.presenter?.presenterSimiliarMovies(similarMovies: moviesRecomended)
                }
            }
        }
    }
    /// Fetch for the get recomended movies
    /// - parameters:
    ///    - url: a String url fetch
    func recomendedMovies(url: String) {
        guard let urlPath = getURL(url: url) else {
            self.presenter?.presenterRecomendedMovies(recomendedMoviess: [])
            return
        }
        movieApi.fetch(urlRequest: urlPath) { (result: Result<MovieResult, NetworkError>) in
            switch result {
            case .failure(let error):
                debugPrint("Error recomended: \(error.localizedDescription)")
            case .success(let movies):
                self.recomendedMovies = movies.results
                DispatchQueue.main.async {
                    guard let moviesRecomended = self.recomendedMovies else {
                        self.presenter?.presenterRecomendedMovies(recomendedMoviess: [])
                        return
                    }
                    self.presenter?.presenterRecomendedMovies(recomendedMoviess: moviesRecomended)
                }
            }
        }
    }
    
    func getURL(url: String) -> URLRequest? {
        guard let urlFetch = URL(string: movieApi.basePath + url + movieApi.apiKey) else {
            return nil
        }
        let urlRequest = URLRequest(url: urlFetch)
        return urlRequest
    }
}
