//
//  MovieDetailPresenterMock.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 07/05/23.
//

import Foundation
@testable import BAZProject

enum MovieDetailPresenterCalls{
    case getSimilar
    case getRecomendation
    case getCast
    case getReviews
    case setCast
    case setReviews
    case setSimilarMovies
    
    case setRecomendedMovies
    case setFavorite
    case findFavoriteMovie
    case favoriteMovie
    case sendToReviews
}


final class MovieDetailPresenterMock: MoviewDetailPresenterProtocol{
    
    var calls: [MovieDetailPresenterCalls] = []
    
    
    func getSimilar(_ id: String) {
        calls.append(.getSimilar)
    }
    
    func getRecomendation(_ id: String) {
        calls.append(.getRecomendation)
    }
    
    func getCast(_ id: String) {
        calls.append(.getCast)
    }
    
    func getReviews(_ id: String) {
        calls.append(.getReviews)
    }
    
    func setCast(_ cast: [BAZProject.Cast]) {
        calls.append(.setCast)
    }
    
    func setReviews(_ reviews: [BAZProject.Review]) {
        calls.append(.setReviews)
    }
    
    func setSimilarMovies(movies: [BAZProject.ListMovieProtocol]) {
        calls.append(.setSimilarMovies)
    }
    
    func setRecomendedMovies(movies: [BAZProject.ListMovieProtocol]) {
        calls.append(.setRecomendedMovies)
    }
    
    func setFavorite(_ isFavorite: Bool) {
        calls.append(.setFavorite)
    }
    
    func findFavoriteMovie(_ id: Int) {
        calls.append(.findFavoriteMovie)
    }
    
    func favoriteMovie(_ movie: BAZProject.ListMovieProtocol) {
        calls.append(.favoriteMovie)
    }
    
    func sendToReviews(reviews: [BAZProject.Review]) {
        calls.append(.sendToReviews)
    }

}
