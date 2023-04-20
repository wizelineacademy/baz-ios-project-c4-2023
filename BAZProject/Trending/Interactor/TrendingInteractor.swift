//
//  TrendingInteractor.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import Foundation

class TrendingInteractor: TrendingInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: TrendingInteractorOutputProtocol?
    var localDatamanager: TrendingLocalDataManagerInputProtocol?
    var remoteDatamanager: TrendingRemoteDataManagerInputProtocol?
    var entity: TrendingEntity?

    func getNavTitle() -> String?{
        return entity?.strNavBarTitle
    }
    
}

extension TrendingInteractor: TrendingRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
