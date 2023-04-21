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
    
    func getImage(pathPoster: String){
        let session = URLSession.shared
        let coordinator = GeneralTaskCoordinator(session: session)
        coordinator.queryValue = pathPoster
                
        coordinator.get(.poster){(result: Result<Data?, Error>) in
            switch result {
                case .success(let poster):
                if let posterData = poster {
                    self.remoteRequestHandler?.handleGetPosterMovies(UIImage(data: posterData))
                }else{
                    self.remoteRequestHandler?.handleGetPosterMovies(UIImage(named: "poster"))
                }
                case .failure(let error):
                    self.remoteRequestHandler?.handleGetErrorServiceSearchedMovies(error)
            }
        }
    }
    
}
