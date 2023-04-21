//
//  UpcomingInteractor.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation

class  UpcomingInteractor: UpcomingInteractorInputProtocol {
    func fetchMovies() {
        self.remoteDatamanager?.fetchMovies()
    }
    
    // MARK: Properties
    weak var presenter: UpcomingInteractorOutputProtocol?
    var remoteDatamanager: UpcomingRemoteDataManagerInputProtocol?

}

extension  UpcomingInteractor: UpcomingRemoteDataManagerOutputProtocol {
    func moviesFetched(_ movies: [Movie]) {
        self.presenter?.moviesFetched(movies: movies)
    }
}

