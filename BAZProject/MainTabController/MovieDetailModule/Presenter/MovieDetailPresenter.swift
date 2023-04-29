//
//  MovieDetailPresenter.swift
//  BAZProject
//
//  Created by 989438 on 27/04/23.
//

import Foundation

final class MovieDetailPresenter {
    weak var view: MovieDetailViewControllerProtocol?
    var router: MovieDetailRouterProtocol?
    var interactor: MovieDetailInteractorInputProtocol?
    var movieModel: [MovieDetailModel] = [] {
        didSet {
            view?.reloadMovieDetailInfo()
        }
    }
    
    var actorArray: [ActorModel] = []
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    func searchForActors(in movie: Int) {
        interactor?.fetchForActors(Endpoint.actors(idMovie: movie))
    }
    
    func searchForSimilarMovies(of movie: Int) {
        interactor?.fetchForSimilarMovies(Endpoint.similar(idMovie: movie))
    }
    
    func searchForRecommendedMovies(of movie: Int) {
        interactor?.fetchForRecommendedMovies(Endpoint.recommended(idMovie: movie))
    }
    
    func getMovieBanner() {
        let movieSummary = MovieDetailModel.summary(movieModel[0].items as? [Movie] ?? [])
        if let movie = movieModel[0].items[0] as? Movie, movieModel[0] == movieSummary {
            interactor?.fetchMovieBanner(movie.backdropPath)
        }
    }
    
    func searchForReviews(for movie: Int) {
        interactor?.fetchUserReviews(Endpoint.reviews(idMovie: movie))
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        
    }
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    func onReceivedActors(with actorList: MovieCast) {
        guard let actors = actorList.cast else { return }
        let topTen = Array(actors.prefix(10))
        interactor?.fetchImageProfile(topTen)
    }
    
    func onReceivedActorModel(withActorModel actor: [ActorModel]) {
        movieModel.append(MovieDetailModel.starring(actor))
        view?.reloadMovieDetailInfo()
    }
    
    func onReceivedSimilarMovies(with movies: MoviesResult) {
        guard let movieList = movies.results else { return }
        interactor?.fetchSimilarImageFrom(movieList)
    }
    
    func onReceivedSimilarMoviesModel(with movies: [Movie]) {
        if movies.count > 0 {
            movieModel.append(MovieDetailModel.similar(movies))
            view?.reloadMovieDetailInfo()
        }
    }
    
    func onReceivedRecommendedMovies(with movies: MoviesResult) {
        guard let movieList = movies.results else { return }
        interactor?.fetchRecommendedImageFrom(movieList)
    }
    
    func onReceivedRecommendedMoviesModel(with movies: [Movie]) {
        if movies.count > 0 {
            movieModel.append(MovieDetailModel.recomended(movies))
            view?.reloadMovieDetailInfo()
        }
    }
    
    func onReceivedMovieBanner(with banner: Data) {
        let movieSummary = MovieDetailModel.summary(movieModel[0].items as? [Movie] ?? [])
        if let movie = movieModel[0].items[0] as? Movie, movieModel[0] == movieSummary {
            movieModel.removeAll()
            movieModel.append(.summary([Movie(id: movie.id, title: movie.title, posterPath: movie.posterPath, summary: movie.summary, backdropPath: movie.backdropPath, backdropPathData: banner)]))
        }
        view?.reloadMovieDetailInfo()
    }
    
    func onReceivedUserReviews(with reviews: ReviewResponse) {
        guard let reviewList = reviews.results else { return }
        interactor?.fetchUserAvatar(reviewList)
    }
    
    func onReceivedUserReviewModel(with reviews: [ReviewModel]) {
        if reviews.count > 0 {
            movieModel.append(MovieDetailModel.reviews(reviews))
            view?.reloadMovieDetailInfo()
        }
    }
    
    func onReceived(with error: Error) {
        view?.reload(with: error)
    }
}
