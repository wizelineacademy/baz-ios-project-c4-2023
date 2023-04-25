//
//  SearchRemoteDataManager.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import UIKit

class SearchRemoteDataManager:SearchRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol?
    
    func getSearchedMovies(_ movie: String) {
        let session = URLSession.shared
        let coordinator = GeneralTaskCoordinator(session: session)
        coordinator.urlPath = "search/movie"
        coordinator.queryValue = movie
                
        coordinator.get(.search){(result: Result<SearchMovieResult, Error>) in
            switch result {
                case .success(let searchedMovies):
                    self.remoteRequestHandler?.handleGetSearchedMovies(searchedMovies.results)
                case .failure(let error):
                    self.remoteRequestHandler?.handleGetErrorServiceSearchedMovies(error)
            }
        }
    }
    
}
