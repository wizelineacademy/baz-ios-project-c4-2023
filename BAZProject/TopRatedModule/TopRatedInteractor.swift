//
//  TopRatedInteractor.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 08/04/23.
//  
//

import Foundation

class TopRatedInteractor: TopRatedInteractorInputProtocol {
    
    // MARK: Properties
    weak var presenter: TopRatedInteractorOutputProtocol?
    var remoteDatamanager: TopRatedRemoteDataManagerInputProtocol?
    
    func fetchMovies() {
        self.remoteDatamanager?.fetchMovies()
    }
}

extension TopRatedInteractor: TopRatedRemoteDataManagerOutputProtocol {
    func moviesFetched(_ movies: [Movie]) {
        self.presenter?.moviesFetched(movies: movies)
    }
}
