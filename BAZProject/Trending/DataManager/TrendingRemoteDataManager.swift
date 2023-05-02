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
    
    func getMovies() {
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
    
}
