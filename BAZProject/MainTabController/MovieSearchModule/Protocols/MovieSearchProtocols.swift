//
//  MovieSearchProtocols.swift
//  BAZProject
//
//  Created by 989438 on 18/04/23.
//

import UIKit

// Presenter > Router
protocol MovieSearchRouterProtocol {
    /**
     Function that create a UIViewController.
     
     - Returns:
         - UIViewController: view
     */
    func createSearchMovieModule() -> UIViewController
    
    /**
     Function that perform a pushed method.
     
     - Parameters:
         - view: UIViewController that is going to push to nextView.
         - nextView: new principal user UIViewController
     */
    func presentDetailViewController(from view: MovieSearchViewControllerProtocol?, withMovie movie: [MovieDetailModel])
}

// View > Presenter
protocol MovieSearchViewControllerProtocol: AnyObject {
    var presenter: MovieSearchPresenterProtocol? { get set }
    
    /**
     Function that reload the view.
     */
    func reloadMovieInfo()
    func fillMovieList()
    
    /**
     Function that reload the view with an specific error.
     
     - Parameters:
         - error: Service module error.
     */
    func reload(with error: Error)
}

// Presenter > View
protocol MovieSearchPresenterProtocol: AnyObject {
    var view: MovieSearchViewControllerProtocol? { get set }
    var router: MovieSearchRouterProtocol? { get set }
    var movieModel: [Movie] { get set }
    
    func searchMovie(withQuery query: String)
    func reloadInfo()
    func didSelectRowAt(_ indexPath: IndexPath)
}

extension MovieSearchPresenterProtocol {
    func linkDependencies(view: MovieSearchViewControllerProtocol, router: MovieSearchRouterProtocol, interactor: MovieSearchInteractorInputProtocol) {
        self.view = view
        (self as? MovieSearchInteractorOutputProtocol)?.interactor = interactor
        self.router = router
    }
}

// Presenter > Interactor
protocol MovieSearchInteractorInputProtocol: AnyObject {
    var presenter: MovieSearchInteractorOutputProtocol? { get set }
    var remoteData: MovieSearchRemoteDataInputProtocol? { get set }
    
    func fetchSearchMovieResults(_ endPoint: EndPointProtocol)
    func fetchImageFrom(_ movie: MovieResult)
    func linkDependencies(remoteData: MovieSearchRemoteDataInputProtocol, presenter: MovieSearchInteractorOutputProtocol)
}

extension MovieSearchInteractorInputProtocol {
    func linkDependencies(remoteData: MovieSearchRemoteDataInputProtocol, presenter: MovieSearchInteractorOutputProtocol) {
        self.presenter = presenter
        self.remoteData = remoteData
    }
}

// Interactor > Presenter
protocol MovieSearchInteractorOutputProtocol: AnyObject {
    var interactor: MovieSearchInteractorInputProtocol? { get set }
    
    func onReceivedSearchedList(with movieList: MoviesResult)
    func onReceivedMovie(with movie: Movie)
    func onReceived(with error: Error)
}

// Interactor > RemoteData
protocol MovieSearchRemoteDataInputProtocol: AnyObject {
    var interactor: MovieSearchRemoteDataOutputProtocol? { get set }
    
    func requestSearchMovie(byEndPoint endPoint: EndPointProtocol)
    func requestImageData(urlString: String, completion: @escaping (Data?) -> Void)
}

// RemoteData > Interactor
protocol MovieSearchRemoteDataOutputProtocol: AnyObject {
    func handleSearchingFetchedList(_ movieList: MoviesResult)
    func handleService(error: Error)
}
