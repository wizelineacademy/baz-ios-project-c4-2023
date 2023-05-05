//
//  MovieDetailsPresenter.swift
//  BAZProject
//
//  Created by Carlos Garcia on 21/04/23.
//  
//

import Foundation
import UIKit

class MovieDetailsPresenter  {
    
    // MARK: Properties
    weak var view: MovieDetailsViewProtocol?
    var interactor: MovieDetailsInteractorInputProtocol?
    var router: MovieDetailsRouterProtocol?
    var movie: MovieInfo?
    
    init(interactor: MovieDetailsInteractorInputProtocol,
         router: MovieDetailsRouterProtocol,
         movie: MovieInfo? = nil) {
        self.interactor = interactor
        self.router = router
        self.movie = movie
        
        self.interactor?.presenter = self
    }
    
    private func getCastDescription(for credits: MovieCreditsInfo?) -> String? {
        guard let arrCast = credits?.cast else { return nil }
        let castDescription = arrCast.reduce("") { partialResult, cast in
            return "\(partialResult)-\(cast.name)"
        }.split(separator: "-").joined(separator: ", ")
        return castDescription
    }
}

extension MovieDetailsPresenter: MovieDetailsPresenterProtocol {
    func present() {
        self.router?.present(presenter: self)
    }
    
    func attach(view: MovieDetailsViewProtocol?) {
        self.view = view
    }
    
    func viewDidLoad() {
        view?.setNavigationTitle(for: interactor?.getNavTitle())
        interactor?.fetchMovieDetails()
        interactor?.verifyFavorite()
    }
    
    func getBackdropImage(with path: String?) {
        guard let path = path else { return }
        interactor?.downloadBackdropImage(with: path)
    }
    
    func showReviewSection() {
        interactor?.fetchMovieReviews()
    }
    
    func showSimilarMoviesSection() {
        interactor?.fetchSimilarMovies()
    }
    
    func showRecommendationsSection() {
        interactor?.fetchRecommendations()
    }
    
    func saveToFavorites() {
        interactor?.saveToFavorites()
    }
    
    func removeFromFavorites() {
        interactor?.removeFromFavorites()
    }
    
    func goToMovieDetails(for movieID: Int) {
        let movie = MovieFoundAdapter(MovieFound(id: movieID, title: ""))
        router?.goToMovieDetailsView(movie, parent: self.view)
    }
}

extension MovieDetailsPresenter: MovieDetailsInteractorOutputProtocol {
    func presentMovieDetails(_ movie: MovieDetailsInfo?) {
        if let movie = movie {
            self.view?.showMovieData(movie, castDescription: getCastDescription(for: movie.credits))
            self.interactor?.fetchMovieReviews()
        } else {
            self.router?.popView()
        }
    }
    
    func presentMovieCredits(_ credits: MovieCreditsInfo?) {
        if let credits = credits {
            self.view?.updateMovieCast(getCastDescription(for: credits))
        }
    }
    
    func presentMovieBackdropImage(_ image: UIImage?) {
        guard let image = image else {
            return
        }
        view?.updateBackdropImage(image)
    }
    
    func presentMovieReviews(_ reviews: [MovieReviewInfo]?) {
        guard let reviews = reviews else {
            return
        }
        view?.showMovieReviews(reviews)
    }
    
    func presentSimilarMovies(_ movies: [MovieInfo]?) {
        guard let movies = movies else { return }
        view?.showSimilarMovies(movies)
    }
    
    func presentRecommendations(_ movies: [MovieInfo]?) {
        guard let movies = movies else { return }
        view?.showRecommendedMovies(movies)
    }
    
    func presentFavoriteMovie(_ isFavorite: Bool) {
        view?.setFavoriteMovieIcon(to: isFavorite)
    }
}
