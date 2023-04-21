//
//  RecentInteractor.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation

class  RecentInteractor: RecentInteractorInputProtocol {
    func fetchMovies() {
        self.remoteDatamanager?.fetchMovies()
    }

    // MARK: Properties
    weak var presenter: RecentInteractorOutputProtocol?
    var remoteDatamanager: RecentRemoteDataManagerInputProtocol?
}

extension RecentInteractor: RecentRemoteDataManagerOutputProtocol {
    func moviesFetched(_ movies: [Movie]) {
        self.presenter?.moviesFetched(movies: movies)
    }
}
