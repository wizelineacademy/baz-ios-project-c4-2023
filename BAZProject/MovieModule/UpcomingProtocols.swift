//
//  MovieProtocols.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//


import UIKit

protocol MovieViewProtocol: AnyObject {
    var presenter: MoviePresenterProtocol? { get set }
    
    func reloadData()
}

protocol MovieRouterProtocol: AnyObject {
    static func createModule(endpoint: Endpoint) -> UIViewController
    func goToMovieDetail(of movieID: Int, from view: UIViewController)
}

protocol MoviePresenterProtocol: AnyObject {
    var view: MovieViewProtocol? { get set }
    var interactor: MovieInteractorInputProtocol? { get set }
    var router: MovieRouterProtocol? { get set }
    var movies: [Movie]? { get set }
    
    func notifyViewLoaded()
    func goToMovieDetail(of index: IndexPath, from view: UIViewController)
}

protocol MovieInteractorOutputProtocol: AnyObject {
    func moviesFetched(movies: [Movie])
}

protocol MovieInteractorInputProtocol: AnyObject {
    var presenter: MovieInteractorOutputProtocol? { get set }
    var remoteDatamanager: MovieRemoteDataManagerInputProtocol? { get set }
    
    func fetchMovies()
}


protocol MovieRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: MovieRemoteDataManagerOutputProtocol? { get set }
    
    func fetchMovies()
}

protocol MovieRemoteDataManagerOutputProtocol: AnyObject {
    func moviesFetched(_ movies: [Movie])
    
    func handleService(error: Error)
}