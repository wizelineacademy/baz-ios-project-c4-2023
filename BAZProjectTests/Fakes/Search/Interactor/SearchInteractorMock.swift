//
//  SearchInteractorMock.swift
//  BAZProjectTests
//
//  Created by Ben Frank V. on 25/04/23.
//

import UIKit

protocol SearchRemoteDataManagerOutputMockProtocol: SearchRemoteDataManagerOutputProtocol{
    func handleGetSearchedMovies(_ result: [Movie])
    func handleGetErrorServiceSearchedMovies(_ error: Error)
}

class SearchInteractorMock: SearchInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: SearchInteractorOutputProtocol?
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol?
    var entity: SearchEntity?
    

    func getNavTitle() -> String?{
        return entity?.strNavBarTitle
    }
    
    func fetchMovies(_ movie: String) {
        remoteDatamanager?.getSearchedMovies(movie)
    }
    
    init(remoteDatamanager: SearchRemoteDataManagerInputProtocol? = SearchRemoteDataManagerMock(), entity: SearchEntity? = nil) {
        self.remoteDatamanager = remoteDatamanager
        self.entity = entity
    }
    
}

extension SearchInteractorMock: SearchRemoteDataManagerOutputMockProtocol {
    
    func handleGetSearchedMovies(_ result: [Movie]) {
        presenter?.onReceivedSearchedMovies(result)
    }
    
    func handleGetErrorServiceSearchedMovies(_ error: Error) {
        presenter?.showSearchedMoviesError(error)
    }
}
