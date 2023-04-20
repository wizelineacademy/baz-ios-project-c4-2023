//
//  SearchInteractor.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import Foundation

class SearchInteractor: SearchInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: SearchInteractorOutputProtocol?
    var localDatamanager: SearchLocalDataManagerInputProtocol?
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol?
    var entity: SearchEntity?

    func getNavTitle() -> String?{
        return entity?.strNavBarTitle
    }
    
}

extension SearchInteractor: SearchRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
