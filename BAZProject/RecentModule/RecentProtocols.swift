//
//  RecentProtocols.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//
import UIKit

protocol RecentViewProtocol: AnyObject {
    var presenter: RecentPresenterProtocol? { get set }
    
    func reloadData()
}

protocol RecentRouterProtocol: AnyObject {
    static func createRecentModule() -> UIViewController
}

protocol RecentPresenterProtocol: AnyObject {
    var view: RecentViewProtocol? { get set }
    var interactor: RecentInteractorInputProtocol? { get set }
    var router: RecentRouterProtocol? { get set }
    var movies: [Movie]? { get set }
    
    func notifyViewLoaded()
}

protocol RecentInteractorOutputProtocol: AnyObject {
    func moviesFetched(movies: [Movie])
}

protocol RecentInteractorInputProtocol: AnyObject {
    var presenter: RecentInteractorOutputProtocol? { get set }
    var remoteDatamanager: RecentRemoteDataManagerInputProtocol? { get set }
    
    func fetchMovies()
}

protocol RecentDataManagerInputProtocol: AnyObject {
}

protocol RecentRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: RecentRemoteDataManagerOutputProtocol? { get set }
    
    func fetchMovies()
}

protocol RecentRemoteDataManagerOutputProtocol: AnyObject {
    func moviesFetched(_ movies: [Movie])
}
