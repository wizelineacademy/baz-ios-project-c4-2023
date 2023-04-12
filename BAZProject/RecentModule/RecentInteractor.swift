//
//  RecentInteractor.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation

class RecentInteractor: RecentInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: RecentInteractorOutputProtocol?
    var localDatamanager: RecentLocalDataManagerInputProtocol?
    var remoteDatamanager: RecentRemoteDataManagerInputProtocol?

}

extension RecentInteractor: RecentRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
