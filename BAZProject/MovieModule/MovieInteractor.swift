//
//  MovieInteractor.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation

class  MovieInteractor: MovieInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: MovieInteractorOutputProtocol?
    var remoteDatamanager: MovieRemoteDataManagerInputProtocol?
    
    func fetchMovies() {
        self.remoteDatamanager?.fetchMovies()
    }

}

extension  MovieInteractor: MovieRemoteDataManagerOutputProtocol {
    func moviesFetched(_ movies: [Movie]) {
        self.presenter?.moviesFetched(movies: movies)
    }
}

