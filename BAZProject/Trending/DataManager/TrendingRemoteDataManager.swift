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
    
    func getMovies(completion handler: @escaping ([Movie]) -> Void) {
        let session = URLSession.shared
        let coordinator = GeneralTaskCoordinator(session: session)
        coordinator.urlPath = "trending/movie/day"
                
        coordinator.get{(result: Result<TrendingMovieResult, Error>) in
            switch result {
                case .success(let trendingMovies):
                    handler(trendingMovies.results)
                case .failure(let error):
                    print(error.localizedDescription.description)
            }
        }
    }
    
}
