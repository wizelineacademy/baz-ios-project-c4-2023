//
//  UpcomingInteractor.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation

class UpcomingInteractor: UpcomingInteractorInputProtocol {

    // MARK: Properties
    weak var presenter: UpcomingInteractorOutputProtocol?
    var localDatamanager: UpcomingLocalDataManagerInputProtocol?
    var remoteDatamanager: UpcomingRemoteDataManagerInputProtocol?

}

extension UpcomingInteractor: UpcomingRemoteDataManagerOutputProtocol {
    // TODO: Implement use case methods
}
