//
//  DetailMovieInteractor.swift
//  BAZProject
//
//  Created by Ben Frank V. on 03/05/23.
//  
//

import Foundation

class DetailMovieInteractor: DetailMovieInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: DetailMovieInteractorOutputProtocol?
    var localDatamanager: DetailMovieLocalDataManagerInputProtocol?
    var remoteDatamanager: DetailMovieRemoteDataManagerInputProtocol?
    var entity: DetailMovieEntity?

    func getNavTitle() -> String?{
        return entity?.strNavBarTitle
    }
    
}

extension DetailMovieInteractor: DetailMovieRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
