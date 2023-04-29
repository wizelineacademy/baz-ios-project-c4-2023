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
}

final class MovieDetailPresenterMock: BAZProject.MovieDetailPresenterProtocol {
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
}
