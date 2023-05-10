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
    
    func registrerCell()
    func updateData(_ result: [Movie])
}

//MARK: - Interactor

/// Interactor -> Presenter
protocol SearchInteractorOutputProtocol: AnyObject {
    func onReceivedSearchedMovies(_ result: [Movie])
    func showSearchedMoviesError(_ error: Error)
}

/// Presenter -> Interactor
protocol SearchInteractorInputProtocol: AnyObject {
    var presenter: SearchInteractorOutputProtocol? { get set }
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol? { get set }
    var entity: SearchEntity? { get set }
    
    func fetchMovies(_ movie: String)
}

//MARK: - Presenter

/// View -> Presenter
protocol SearchPresenterProtocol: AnyObject {
    var view: SearchViewProtocol? { get set }
    var interactor: SearchInteractorInputProtocol? { get set }
    var router: SearchRouterProtocol? { get set }
    var tableView: UITableView { get set }
    
    func viewDidLoad()
    func willFetchMovies(_ movie: String)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
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
    func getSearchedMovies(_ movie: String)
}

/// Remote data manager -> Interactor
protocol SearchRemoteDataManagerOutputProtocol: AnyObject {
    func handleGetSearchedMovies(_ result: [Movie])
    func handleGetErrorServiceSearchedMovies(_ error: Error)
    
}
