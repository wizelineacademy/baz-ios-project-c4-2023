//
//  TrendingProtocols.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 08/04/23.
//  
//

import UIKit

protocol TrendingViewProtocol: AnyObject {
    var presenter: TrendingPresenterProtocol? { get set }
    
    func reloadData()
}

protocol TrendingRouterProtocol: AnyObject {
    static func createTrendingModule() -> UIViewController
}

protocol TrendingPresenterProtocol: AnyObject {
    var view: TrendingViewProtocol? { get set }
    var interactor: TrendingInteractorInputProtocol? { get set }
    var router: TrendingRouterProtocol? { get set }
    var movies: [Movie]? { get set }
    
    func notifyViewLoaded()
}

protocol TrendingInteractorOutputProtocol: AnyObject {
    func moviesFetched(movies: [Movie])
}

protocol TrendingInteractorInputProtocol: AnyObject {
    var presenter: TrendingInteractorOutputProtocol? { get set }
    var remoteDatamanager: TrendingRemoteDataManagerInputProtocol? { get set }
    
    func fetchMovies()
}

protocol TrendingDataManagerInputProtocol: AnyObject {
}

protocol TrendingRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: TrendingRemoteDataManagerOutputProtocol? { get set }
    
    func fetchMovies()
}

protocol TrendingRemoteDataManagerOutputProtocol: AnyObject {
    func moviesFetched(_ movies: [Movie])
    func handleService(error: Error)
}
