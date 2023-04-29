//
//  MovieDetailInteractorMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 29/04/23.
//

import Foundation
@testable import BAZProject

enum MovieDetailInteractorMockCalls {
    case fetchForActors
    case fetchForSimilarMovies
    case fetchForRecommendedMovies
    case fetchMovieBanner
    case fetchSimilarImageFrom
    case fetchRecommendedImageFrom
    case fetchImageProfile
    case fetchUserReviews
    case fetchUserAvatar
    case handleActorsFetchedList
    case handleSimilarMoviesFetchedList
    case handleRecommendedMoviesFetchedList
    case handleUserReviewsFetchedList
    case handleServiceWithError
}

final class MovieDetailInteractorMock: BAZProject.MovieDetailInteractorInputProtocol, BAZProject.MovieDetailRemoteDataOutputProtocol {
    var presenter: BAZProject.MovieDetailInteractorOutputProtocol?
    var remoteData: BAZProject.MovieDetailRemoteDataInputProtocol?
    var calls: [MovieDetailInteractorMockCalls] = []
    
    func fetchForActors(_ endPoint: BAZProject.EndPointProtocol) {
        calls.append(.fetchForActors)
    }
    
    func fetchForSimilarMovies(_ endPoint: BAZProject.EndPointProtocol) {
        calls.append(.fetchForSimilarMovies)
    }
    
    func fetchForRecommendedMovies(_ endPoint: BAZProject.EndPointProtocol) {
        calls.append(.fetchForRecommendedMovies)
    }
    
    func fetchMovieBanner(_ urlString: String) {
        calls.append(.fetchMovieBanner)
    }
    
    func fetchSimilarImageFrom(_ movies: [BAZProject.MovieResult]) {
        calls.append(.fetchSimilarImageFrom)
    }
    
    func fetchRecommendedImageFrom(_ movies: [BAZProject.MovieResult]) {
        calls.append(.fetchRecommendedImageFrom)
    }
    
    func fetchImageProfile(_ actors: [BAZProject.Actor]) {
        calls.append(.fetchImageProfile)
    }
    
    func fetchUserReviews(_ endPoint: BAZProject.EndPointProtocol) {
        calls.append(.fetchUserReviews)
    }
    
    func fetchUserAvatar(_ reviews: [BAZProject.Review]) {
        calls.append(.fetchUserAvatar)
    }
    
    func handleActorsFetchedList(_ actorList: BAZProject.MovieCast) {
        calls.append(.handleActorsFetchedList)
    }
    
    func handleSimilarMoviesFetchedList(_ movieList: BAZProject.MoviesResult) {
        calls.append(.handleSimilarMoviesFetchedList)
    }
    
    func handleRecommendedMoviesFetchedList(_ movieList: BAZProject.MoviesResult) {
        calls.append(.handleRecommendedMoviesFetchedList)
    }
    
    func handleUserReviewsFetchedList(_ reviewList: BAZProject.ReviewResponse) {
        calls.append(.handleUserReviewsFetchedList)
    }
    
    func handleService(error: Error) {
        calls.append(.handleServiceWithError)
    }
}
