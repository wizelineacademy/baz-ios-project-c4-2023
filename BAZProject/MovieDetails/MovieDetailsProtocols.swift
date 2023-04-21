//
//  MovieDetailsProtocols.swift
//  BAZProject
//
//  Created by Carlos Garcia on 21/04/23.
//  
//

import Foundation
import UIKit

//MARK: - View

/// Presenter -> View
protocol MovieDetailsViewProtocol: AnyObject {
    var presenter: MovieDetailsPresenterProtocol? { get set }
    
    func setNavigationTitle(for strTitle: String?)
    func showMovieData(_ movie: MovieInfo)
}

//MARK: - Interactor

/// Interactor -> Presenter
protocol MovieDetailsInteractorOutputProtocol: AnyObject {
}

/// Presenter -> Interactor
protocol MovieDetailsInteractorInputProtocol: AnyObject {
    var presenter: MovieDetailsInteractorOutputProtocol? { get set }
    var localDatamanager: MovieDetailsLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: MovieDetailsRemoteDataManagerInputProtocol? { get set }
    var entity: MovieDetailsEntity? { get set }
    
    func getNavTitle() -> String?
    func getMovie() -> MovieInfo?
}

//MARK: - Presenter

/// View -> Presenter
protocol MovieDetailsPresenterProtocol: AnyObject {
    var view: MovieDetailsViewProtocol? { get set }
    var interactor: MovieDetailsInteractorInputProtocol? { get set }
    var router: MovieDetailsRouterProtocol? { get set }
    
    func viewDidLoad()
    func attach(view: MovieDetailsViewProtocol?)
    func present()
}

//MARK: - Router

/// Presenter -> Router
protocol MovieDetailsRouterProtocol: AnyObject {
    func present(presenter: MovieDetailsPresenterProtocol)
}

//MARK: - Data Manager

/// Interactor -> Remote data manager
protocol MovieDetailsRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: MovieDetailsRemoteDataManagerOutputProtocol? { get set }
}

/// Remote data manager -> Interactor
protocol MovieDetailsRemoteDataManagerOutputProtocol: AnyObject {
}

/// Interactor -> Local data manager
protocol MovieDetailsLocalDataManagerInputProtocol: AnyObject {
}
