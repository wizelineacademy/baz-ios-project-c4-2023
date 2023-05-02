//
//  MovieDetailsInteractor.swift
//  BAZProject
//
//  Created by Carlos Garcia on 21/04/23.
//  
//

import Foundation

class MovieDetailsInteractor: MovieDetailsInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: MovieDetailsInteractorOutputProtocol?
    var localDatamanager: MovieDetailsLocalDataManagerInputProtocol?
    var remoteDatamanager: MovieDetailsRemoteDataManagerInputProtocol?
    var entity: MovieDetailsEntity?

    func getNavTitle() -> String?{
        return entity?.strNavBarTitle
    }
    
    func getMovie() -> MovieInfo? {
        entity?.movie
    }
}

extension MovieDetailsInteractor: MovieDetailsRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
