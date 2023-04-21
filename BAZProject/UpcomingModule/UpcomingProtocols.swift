//
//  UpcomingProtocols.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//


import UIKit

protocol UpcomingViewProtocol: AnyObject {
    var presenter: UpcomingPresenterProtocol? { get set }
    
    func reloadData()
}

protocol UpcomingRouterProtocol: AnyObject {
    static func createUpcomingModule() -> UIViewController
}

protocol UpcomingPresenterProtocol: AnyObject {
    var view: UpcomingViewProtocol? { get set }
    var interactor: UpcomingInteractorInputProtocol? { get set }
    var router: UpcomingRouterProtocol? { get set }
    var movies: [Movie]? { get set }
    
    func notifyViewLoaded()
}

protocol UpcomingInteractorOutputProtocol: AnyObject {
    func moviesFetched(movies: [Movie])
}

protocol UpcomingInteractorInputProtocol: AnyObject {
    var presenter: UpcomingInteractorOutputProtocol? { get set }
    var remoteDatamanager: UpcomingRemoteDataManagerInputProtocol? { get set }
    
    func fetchMovies()
}

protocol UpcomingDataManagerInputProtocol: AnyObject {
}

protocol UpcomingRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: UpcomingRemoteDataManagerOutputProtocol? { get set }
    
    func fetchMovies()
}

protocol UpcomingRemoteDataManagerOutputProtocol: AnyObject {
    func moviesFetched(_ movies: [Movie])
}
