//
//  DetailMovieProtocols.swift
//  BAZProject
//
//  Created by Ben Frank V. on 03/05/23.
//  
//

import Foundation
import UIKit

//MARK: - View

/// Presenter -> View
protocol DetailMovieViewProtocol: AnyObject {
    var presenter: DetailMoviePresenterProtocol? { get set }
    func registrerCell()
    func updateData(_ result: [Movie])
}

//MARK: - Interactor

/// Interactor -> Presenter
protocol DetailMovieInteractorOutputProtocol: AnyObject {
    func onReceivedMovieDetails(_ result: DetailMovieEntity)
    func showSearchedMoviesError(_ error: Error)
}

/// Presenter -> Interactor
protocol DetailMovieInteractorInputProtocol: AnyObject {
    var presenter: DetailMovieInteractorOutputProtocol? { get set }
    //var localDatamanager: DetailMovieLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: DetailMovieRemoteDataManagerInputProtocol? { get set }
    var entity: DetailMovieEntity? { get set }
    
    func fetchDetailsMovie()
}

//MARK: - Presenter

/// View -> Presenter
protocol DetailMoviePresenterProtocol: AnyObject {
    var view: DetailMovieViewProtocol? { get set }
    var interactor: DetailMovieInteractorInputProtocol? { get set }
    var router: DetailMovieRouterProtocol? { get set }
    
    func viewDidLoad()
    func willFetchDetailsMovie()
}

//MARK: - Router

/// Presenter -> Router
protocol DetailMovieRouterProtocol: AnyObject {
    static func createDetailMovieModule(withEntity entity: DetailMovieEntity) -> UIViewController
    //static func createDetailMovieModule() -> UIViewController
}

//MARK: - Data Manager

/// Interactor -> Remote data manager
protocol DetailMovieRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: DetailMovieRemoteDataManagerOutputProtocol? { get set }
    func getReviewsMovie(_ movie: Int)
    func getCastingMovie(_ movie: Int)
    func getGetMovieRecommendations(_ movie: Int)
    func getGetSimilarMovies(_ movie: Int)
}

/// Remote data manager -> Interactor
protocol DetailMovieRemoteDataManagerOutputProtocol: AnyObject {
    func handleGetReviewsMovie(_ result: [MovieReviews])
    func handleGetCreditsMovie(_ result: MovieCreditsResult)
    func handleGetMovieRecommendations(_ result: [Movie])
    func handleGetSimilarMovies(_ result: [Movie])
    func handleGetErrorServiceDetailMovies(_ error: Error)
}

/// Interactor -> Local data manager
protocol DetailMovieLocalDataManagerInputProtocol: AnyObject {
}
