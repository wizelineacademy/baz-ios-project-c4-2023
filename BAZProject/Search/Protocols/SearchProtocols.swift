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
    func registrerCell()
    func updateData(_ result: [SearchedMovies])
}

//MARK: - Interactor

/// Interactor -> Presenter
protocol SearchInteractorOutputProtocol: AnyObject {
    func onReceivedSearchedMovies(_ result: [SearchedMovies])
    func showSearchedMoviesError(_ error: Error)
    func onReceivedPosterMovies(_ result: UIImage?)
    func showPosterMoviesError(_ error: Error)
}

/// Presenter -> Interactor
protocol SearchInteractorInputProtocol: AnyObject {
    var presenter: SearchInteractorOutputProtocol? { get set }
    //var localDatamanager: SearchLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol? { get set }
    var entity: SearchEntity? { get set }
    
    func getNavTitle() -> String?
    func fetchMovies(_ movie: String)
    func fetchPoster(_ poster: String)
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
    func willFetchPoster(_ posterº: String)
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
    func getImage(pathPoster: String)
}

/// Remote data manager -> Interactor
protocol SearchRemoteDataManagerOutputProtocol: AnyObject {
    func handleGetSearchedMovies(_ result: [SearchedMovies])
    func handleGetErrorServiceSearchedMovies(_ error: Error)
    func handleGetPosterMovies(_ result: UIImage?)
    func handleGetErrorServicePosterMovies(_ error: Error)
    
}

/// Interactor -> Local data manager
//protocol SearchLocalDataManagerInputProtocol: AnyObject {
//}
