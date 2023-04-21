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
    //var localDatamanager: SearchLocalDataManagerInputProtocol?
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol?
    var entity: SearchEntity?

    func getNavTitle() -> String?{
        return entity?.strNavBarTitle
    }
    
    func fetchMovies(_ movie: String) {
        remoteDatamanager?.getSearchedMovies(movie)
    }
    
    func fetchPoster(_ poster: String) {
        remoteDatamanager?.getImage(pathPoster: poster)
    }
    
}

extension SearchInteractor: SearchRemoteDataManagerOutputProtocol {
    func handleGetPosterMovies(_ result: UIImage?) {
        presenter?.onReceivedPosterMovies(result)
    }
    
    func handleGetErrorServicePosterMovies(_ error: Error) {
        presenter?.showPosterMoviesError(error)
    }
    
    func handleGetSearchedMovies(_ result: [SearchedMovies]) {
        presenter?.onReceivedSearchedMovies(result)
    }
    
    func handleGetErrorServiceSearchedMovies(_ error: Error) {
        presenter?.showSearchedMoviesError(error)
    }
}
