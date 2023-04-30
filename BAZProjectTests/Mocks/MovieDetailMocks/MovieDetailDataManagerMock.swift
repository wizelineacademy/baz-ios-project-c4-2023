//
//  MovieDetailDataManagerMock.swift
//  BAZProjectTests
//
//  Created by 989438 on 29/04/23.
//

import Foundation
@testable import BAZProject
import XCTest

enum MovieDetailDataManagerMockCalls {
    case requestActors
    case requestSimilarMovies
    case requestRecommendedMovies
    case requestImageData
    case requestProfileImageData
    case requestMoviesImageData
    case requestUserImageData
    case requestUserReviews
}

final class MovieDetailDataManagerMock: BAZProject.MovieDetailRemoteDataInputProtocol {
    var interactor: BAZProject.MovieDetailRemoteDataOutputProtocol?
    var calls: [MovieDetailDataManagerMockCalls] = []
    var expectation: XCTestExpectation?
    
    func requestActors(withEndPoint endPoint: BAZProject.EndPointProtocol) {
        calls.append(.requestActors)
    }
    
    func requestSimilarMovies(withEndPoint endPoint: BAZProject.EndPointProtocol) {
        calls.append(.requestSimilarMovies)
    }
    
    func requestRecommendedMovies(withEndPoint endPoint: BAZProject.EndPointProtocol) {
        calls.append(.requestRecommendedMovies)
    }
    
    func requestImageData(urlString: String, completion: @escaping (Data?) -> Void) {
        calls.append(.requestImageData)
        expectation?.fulfill()
    }
    
    func requestProfileImageData(actors: [BAZProject.Actor], completion: @escaping ([BAZProject.ActorModel]) -> Void) {
        calls.append(.requestProfileImageData)
    }
    
    func requestMoviesImageData(movies: [BAZProject.MovieResult], completion: @escaping ([BAZProject.Movie]) -> Void) {
        calls.append(.requestMoviesImageData)
    }
    
    func requestUserImageData(reviews: [BAZProject.Review], completion: @escaping ([BAZProject.ReviewModel]) -> Void) {
        calls.append(.requestUserImageData)
    }
    
    func requestUserReviews(withEndPoint endPoint: BAZProject.EndPointProtocol) {
        calls.append(.requestUserReviews)
    }
}
