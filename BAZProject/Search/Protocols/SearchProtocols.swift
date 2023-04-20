//
//  SearchProtocols.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import Foundation
import UIKit

//MARK: - View

/// Presenter -> View
protocol SearchViewProtocol: AnyObject {
    var presenter: SearchPresenterProtocol? { get set }
    
    func setNavigationTitle(for strTitle: String?)
}

//MARK: - Interactor

/// Interactor -> Presenter
protocol SearchInteractorOutputProtocol: AnyObject {
}

/// Presenter -> Interactor
protocol SearchInteractorInputProtocol: AnyObject {
    var presenter: SearchInteractorOutputProtocol? { get set }
    var localDatamanager: SearchLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol? { get set }
    var entity: SearchEntity? { get set }
    
    func getNavTitle() -> String?
}

//MARK: - Presenter

/// View -> Presenter
protocol SearchPresenterProtocol: AnyObject {
    var view: SearchViewProtocol? { get set }
    var interactor: SearchInteractorInputProtocol? { get set }
    var router: SearchRouterProtocol? { get set }
    
    func viewDidLoad()
}

//MARK: - Router

/// Presenter -> Router
protocol SearchRouterProtocol: AnyObject {
    static func createSearchModule(withEntity entity: SearchEntity) -> UIViewController
}

//MARK: - Data Manager

/// Interactor -> Remote data manager
protocol SearchRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol? { get set }
}

/// Remote data manager -> Interactor
protocol SearchRemoteDataManagerOutputProtocol: AnyObject {
}

/// Interactor -> Local data manager
protocol SearchLocalDataManagerInputProtocol: AnyObject {
}
