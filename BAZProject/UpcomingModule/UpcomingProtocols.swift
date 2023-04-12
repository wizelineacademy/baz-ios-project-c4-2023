//
//  UpcomingProtocols.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation
import UIKit

protocol UpcomingViewProtocol: AnyObject {
    var presenter: UpcomingPresenterProtocol? { get set }
}

protocol UpcomingWireFrameProtocol: AnyObject {
    static func createUpcomingModule() -> UIViewController
}

protocol UpcomingPresenterProtocol: AnyObject {
    var view: UpcomingViewProtocol? { get set }
    var interactor: UpcomingInteractorInputProtocol? { get set }
    var wireFrame: UpcomingWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

protocol UpcomingInteractorOutputProtocol: AnyObject {
}

protocol UpcomingInteractorInputProtocol: AnyObject {
    var presenter: UpcomingInteractorOutputProtocol? { get set }
    var localDatamanager: UpcomingLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: UpcomingRemoteDataManagerInputProtocol? { get set }
}

protocol UpcomingDataManagerInputProtocol: AnyObject {
}

protocol UpcomingRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: UpcomingRemoteDataManagerOutputProtocol? { get set }
}

protocol UpcomingRemoteDataManagerOutputProtocol: AnyObject {
}

protocol UpcomingLocalDataManagerInputProtocol: AnyObject {
}
