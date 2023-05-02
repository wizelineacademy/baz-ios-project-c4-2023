//
//  SearchRemoteDataManagerMock.swift
//  BAZProjectTests
//
//  Created by Ben Frank V. on 25/04/23.
//

import UIKit

class SearchRemoteDataManagerMock: SearchRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol?
    
    init() {
        var mock: SearchRemoteDataManagerOutputMockProtocol?
        self.remoteRequestHandler = mock
    }
    
    func getSearchedMovies(_ movie: String) {
        let session = URLSession.shared
        let coordinator = GeneralTaskCoordinatorMock(session: session)
        coordinator.urlPath = "search/movie"
        coordinator.fileName = "Search"
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
