//
//  DetailMovieProtocols.swift
//  BAZProject
//
//  Created by Ben Frank V. on 03/05/23.
//  
//

import Foundation
import UIKit

//MARK: - View

/// Presenter -> View
protocol DetailMovieViewProtocol: AnyObject {
    var presenter: DetailMoviePresenterProtocol? { get set }
    
    func setNavigationTitle(for strTitle: String?)
}

//MARK: - Interactor

/// Interactor -> Presenter
protocol DetailMovieInteractorOutputProtocol: AnyObject {
}

/// Presenter -> Interactor
protocol DetailMovieInteractorInputProtocol: AnyObject {
    var presenter: DetailMovieInteractorOutputProtocol? { get set }
    //var localDatamanager: DetailMovieLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: DetailMovieRemoteDataManagerInputProtocol? { get set }
    var entity: DetailMovieEntity? { get set }
    
    func getNavTitle() -> String?
}

//MARK: - Presenter

/// View -> Presenter
protocol DetailMoviePresenterProtocol: AnyObject {
    var view: DetailMovieViewProtocol? { get set }
    var interactor: DetailMovieInteractorInputProtocol? { get set }
    var router: DetailMovieRouterProtocol? { get set }
    
    func viewDidLoad()
}

//MARK: - Router

/// Presenter -> Router
protocol DetailMovieRouterProtocol: AnyObject {
    //static func createDetailMovieModule(withEntity entity: DetailMovieEntity) -> UIViewController
    static func createDetailMovieModule() -> UIViewController
}

//MARK: - Data Manager

/// Interactor -> Remote data manager
protocol DetailMovieRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: DetailMovieRemoteDataManagerOutputProtocol? { get set }
}

/// Remote data manager -> Interactor
protocol DetailMovieRemoteDataManagerOutputProtocol: AnyObject {
}

/// Interactor -> Local data manager
protocol DetailMovieLocalDataManagerInputProtocol: AnyObject {
}
