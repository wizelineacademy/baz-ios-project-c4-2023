//
//  MovieDetailPresenterMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 29/04/23.
//

import Foundation
@testable import BAZProject

enum MovieDetailPresenterMockCalls {
    case searchForActors
    case searchForSimilarMovies
    case searchForRecommendedMovies
    case searchForReviews
    case getMovieBanner
    case didSelectRowAt
    case onReceivedActors
    case onReceivedActorModel
    case onReceivedSimilarMovies
    case onReceivedSimilarMoviesModel
    case onReceivedRecommendedMovies
    case onReceivedRecommendedMoviesModel
    case onReceivedMovieBanner
    case onReceivedWithError
    case onReceivedUserReviews
    case onReceivedUserReviewModel
}

final class MovieDetailPresenterMock: BAZProject.MovieDetailPresenterProtocol, MovieDetailInteractorOutputProtocol {
    var interactor: BAZProject.MovieDetailInteractorInputProtocol?
    var view: BAZProject.MovieDetailViewControllerProtocol?
    var router: BAZProject.MovieDetailRouterProtocol?
    var movieModel: [BAZProject.MovieDetailModel] = []
    var calls: [MovieDetailPresenterMockCalls] = []
    
    func searchForActors(in movie: Int) {
        calls.append(.searchForActors)
    }
    
    func searchForSimilarMovies(of movie: Int) {
        calls.append(.searchForSimilarMovies)
    }
    
    func searchForRecommendedMovies(of movie: Int) {
        calls.append(.searchForRecommendedMovies)
    }
    
    func searchForReviews(for movie: Int) {
        calls.append(.searchForReviews)
    }
    
    func getMovieBanner() {
        calls.append(.getMovieBanner)
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        calls.append(.didSelectRowAt)
    }
    
    func onReceivedActors(with actorList: BAZProject.MovieCast) {
        calls.append(.onReceivedActors)
    }
    
    func onReceivedActorModel(withActorModel actor: [BAZProject.ActorModel]) {
        calls.append(.onReceivedActorModel)
    }
    
    func onReceivedSimilarMovies(with movies: BAZProject.MoviesResult) {
        calls.append(.onReceivedSimilarMovies)
    }
    
    func onReceivedSimilarMoviesModel(with movies: [BAZProject.Movie]) {
        calls.append(.onReceivedSimilarMoviesModel)
    }
    
    func onReceivedRecommendedMovies(with movies: BAZProject.MoviesResult) {
        calls.append(.onReceivedRecommendedMovies)
    }
    
    func onReceivedRecommendedMoviesModel(with movies: [BAZProject.Movie]) {
        calls.append(.onReceivedRecommendedMoviesModel)
    }
    
    func onReceivedMovieBanner(with banner: Data) {
        calls.append(.onReceivedMovieBanner)
    }
    
    func onReceived(with error: Error) {
        calls.append(.onReceivedWithError)
    }
    
    func onReceivedUserReviews(with reviews: BAZProject.ReviewResponse) {
        calls.append(.onReceivedUserReviews)
    }
    
    func onReceivedUserReviewModel(with reviews: [BAZProject.ReviewModel]) {
        calls.append(.onReceivedUserReviewModel)
    }
    
    func didSelectRowAt(_ indexPath: IndexPath, _ items: [BAZProject.Movie]) {
        calls.append(.didSelectRowAt)
    }
}
