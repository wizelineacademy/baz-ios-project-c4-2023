//
//  TopRatedProtocols.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 08/04/23.
//  
//
import UIKit
import Foundation

protocol TopRatedViewProtocol: AnyObject {
    var presenter: TopRatedPresenterProtocol? { get set }
    
    func reloadData()
}

protocol TopRatedRouterProtocol: AnyObject {
    static func createTopRatedModule() -> UIViewController
}

protocol TopRatedPresenterProtocol: AnyObject {
    var view: TopRatedViewProtocol? { get set }
    var interactor: TopRatedInteractorInputProtocol? { get set }
    var router: TopRatedRouterProtocol? { get set }
    var movies: [Movie]? { get set }
    
    func notifyViewLoaded()
}

protocol TopRatedInteractorOutputProtocol: AnyObject {
    func moviesFetched(movies: [Movie])
}

protocol TopRatedInteractorInputProtocol: AnyObject {
    var presenter: TopRatedInteractorOutputProtocol? { get set }
    var remoteDatamanager: TopRatedRemoteDataManagerInputProtocol? { get set }
    
    func fetchMovies()
}

protocol TopRatedDataManagerInputProtocol: AnyObject {
}

protocol TopRatedRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: TopRatedRemoteDataManagerOutputProtocol? { get set }
    
    func fetchMovies()
}

protocol TopRatedRemoteDataManagerOutputProtocol: AnyObject {
    func moviesFetched(_ movies: [Movie])
}
