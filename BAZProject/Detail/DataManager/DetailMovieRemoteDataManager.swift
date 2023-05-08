//
//  DetailMovieRemoteDataManager.swift
//  BAZProject
//
//  Created by Ben Frank V. on 03/05/23.
//  
//

import Foundation

class DetailMovieRemoteDataManager:DetailMovieRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: DetailMovieRemoteDataManagerOutputProtocol?
    
    func getReviewsMovie(_ movie: Int) {
        let session = URLSession.shared
        let coordinator = GeneralTaskCoordinator(session: session)
        coordinator.languageValueDefault = .languageValueEnglish
        coordinator.regionValueDefault = .regionValueUSA
        coordinator.urlPath = "movie/\(movie)/reviews"
        
        coordinator.get(){(result: Result<MovieReviewsResult, Error>) in
            switch result {
                case .success(let movieReviews):
                    self.remoteRequestHandler?.handleGetReviewsMovie(movieReviews.results)
                case .failure(let error):
                    self.remoteRequestHandler?.handleGetErrorServiceDetailMovies(error)
            }
        }
    }
    
    func getCastingMovie(_ movie: Int) {
        let session = URLSession.shared
        let coordinator = GeneralTaskCoordinator(session: session)
        coordinator.urlPath = "movie/\(movie)/credits"
        
        coordinator.get(){(result: Result<MovieCreditsResult, Error>) in
            switch result {
                case .success(let movieCredits):
                self.remoteRequestHandler?.handleGetCreditsMovie(movieCredits)
                case .failure(let error):
                    self.remoteRequestHandler?.handleGetErrorServiceDetailMovies(error)
            }
        }
    }
    
    func getGetMovieRecommendations(_ movie: Int) {
        let session = URLSession.shared
        let coordinator = GeneralTaskCoordinator(session: session)
        coordinator.urlPath = "movie/\(movie)/recommendations"
        
        coordinator.get(){(result: Result<MovieRecommendationsResult, Error>) in
            switch result {
                case .success(let recommendations):
                self.remoteRequestHandler?.handleGetMovieRecommendations(recommendations.results)
                case .failure(let error):
                    self.remoteRequestHandler?.handleGetErrorServiceDetailMovies(error)
            }
        }
    }
    
    func getGetSimilarMovies(_ movie: Int) {
        let session = URLSession.shared
        let coordinator = GeneralTaskCoordinator(session: session)
        coordinator.urlPath = "movie/\(movie)/similar"
        
        coordinator.get(){(result: Result<SimilarMoviesResult, Error>) in
            switch result {
                case .success(let similarMovies):
                self.remoteRequestHandler?.handleGetSimilarMovies(similarMovies.results)
                case .failure(let error):
                    self.remoteRequestHandler?.handleGetErrorServiceDetailMovies(error)
            }
        }
    }
    
    
    
    
}
