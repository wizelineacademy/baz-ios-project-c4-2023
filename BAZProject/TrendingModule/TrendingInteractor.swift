//
//  TrendingInteractor.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 08/04/23.
//  
//

import Foundation

class TrendingInteractor: TrendingInteractorInputProtocol {
    func fetchMovies() {
        self.remoteDatamanager?.fetchMovies()
    }
    

    // MARK: Properties
    weak var presenter: TrendingInteractorOutputProtocol?
    var remoteDatamanager: TrendingRemoteDataManagerInputProtocol?

}

extension TrendingInteractor: TrendingRemoteDataManagerOutputProtocol {
    func moviesFetched(_ movies: [Movie]) {
        self.presenter?.moviesFetched(movies: movies)
    }
}
