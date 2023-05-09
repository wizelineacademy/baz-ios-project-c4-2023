//
//  SearchInteractor.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import Foundation
import UIKit

class SearchInteractor: SearchInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: SearchInteractorOutputProtocol?
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol?
    var entity: SearchEntity?
    
    func fetchMovies(_ movie: String) {
        remoteDatamanager?.getSearchedMovies(movie)
    }
    
}

extension SearchInteractor: SearchRemoteDataManagerOutputProtocol {
    
    func handleGetSearchedMovies(_ result: [Movie]) {
        presenter?.onReceivedSearchedMovies(result)
    }
    
    func handleGetErrorServiceSearchedMovies(_ error: Error) {
        presenter?.showSearchedMoviesError(error)
    }
}
