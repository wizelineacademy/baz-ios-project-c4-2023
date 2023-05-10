//
//  TrendingRemoteDataManager.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import Foundation

class TrendingRemoteDataManager:TrendingRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: TrendingRemoteDataManagerOutputProtocol?
    
    func getMoviesTrending() {
        let session = URLSession.shared
        let coordinator = GeneralTaskCoordinator(session: session)
        coordinator.urlPath = "trending/movie/day"
                
        coordinator.get{(result: Result<TrendingMovieResult, Error>) in
            switch result {
                case .success(let trendingMovies):
                    self.remoteRequestHandler?.handleGetMovies(trendingMovies.results)
                case .failure(let error):
                    self.remoteRequestHandler?.handleGetErrorServiceMovies(error)
            }
        }
    }
    
    func getNowPlaying() {
        let session = URLSession.shared
        let coordinator = GeneralTaskCoordinator(session: session)
        coordinator.urlPath = "movie/now_playing"
                
        coordinator.get{(result: Result<TrendingMovieResult, Error>) in
            switch result {
                case .success(let trendingMovies):
                    self.remoteRequestHandler?.handleGetNowPlaying(trendingMovies.results)
                case .failure(let error):
                    self.remoteRequestHandler?.handleGetErrorServiceMovies(error)
            }
        }
    }
    
    func getPopular() {
        let session = URLSession.shared
        let coordinator = GeneralTaskCoordinator(session: session)
        coordinator.urlPath = "movie/popular"
                
        coordinator.get{(result: Result<TrendingMovieResult, Error>) in
            switch result {
                case .success(let trendingMovies):
                    self.remoteRequestHandler?.handleGetPopular(trendingMovies.results)
                case .failure(let error):
                    self.remoteRequestHandler?.handleGetErrorServiceMovies(error)
            }
        }
    }
    
    func getTopRated() {
        let session = URLSession.shared
        let coordinator = GeneralTaskCoordinator(session: session)
        coordinator.urlPath = "movie/top_rated"
                
        coordinator.get{(result: Result<TrendingMovieResult, Error>) in
            switch result {
                case .success(let trendingMovies):
                    self.remoteRequestHandler?.handleGetTopRated(trendingMovies.results)
                case .failure(let error):
                    self.remoteRequestHandler?.handleGetErrorServiceMovies(error)
            }
        }
    }
    
    func getUpcoming() {
        let session = URLSession.shared
        let coordinator = GeneralTaskCoordinator(session: session)
        coordinator.urlPath = "movie/upcoming"
                
        coordinator.get{(result: Result<TrendingMovieResult, Error>) in
            switch result {
                case .success(let trendingMovies):
                    self.remoteRequestHandler?.handleGetUpcoming(trendingMovies.results)
                case .failure(let error):
                    self.remoteRequestHandler?.handleGetErrorServiceMovies(error)
            }
        }
    }
    
}
