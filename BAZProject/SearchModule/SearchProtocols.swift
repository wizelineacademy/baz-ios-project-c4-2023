//
//  SearchProtocols.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 10/04/23.
//  
//
import UIKit

protocol SearchViewProtocol: AnyObject {
    var presenter: SearchPresenterProtocol? { get set }
    
    func reloadData()
}

protocol SearchRouterProtocol: AnyObject {
    static func createSearchModule() -> UIViewController
}

protocol SearchPresenterProtocol: AnyObject {
    var view: SearchViewProtocol? { get set }
    var interactor: SearchInteractorInputProtocol? { get set }
    var router: SearchRouterProtocol? { get set }
    var searchResults: [SearchResult]? { get set }
    
    func searchMovies(with query: String?)
}

protocol SearchInteractorOutputProtocol: AnyObject {
    
    func searchResultsFecthed(searchResults: [SearchResult])
}

protocol SearchInteractorInputProtocol: AnyObject {
    var presenter: SearchInteractorOutputProtocol? { get set }
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol? { get set }
    
    func fetchSearchResults(with query: String)
}

protocol SearchRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol? { get set }
    
    func fetchSearchResults(with query: String)
}

protocol SearchRemoteDataManagerOutputProtocol: AnyObject {
    func searchResultsFecthed(searchResults: [SearchResult])
}
