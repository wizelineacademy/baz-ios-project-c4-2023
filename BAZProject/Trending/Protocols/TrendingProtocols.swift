//
//  TrendingProtocols.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import Foundation
import UIKit

//MARK: - View

/// Presenter -> View
protocol TrendingViewProtocol: AnyObject {
    var presenter: TrendingPresenterProtocol? { get set }
    
    func setNavigationTitle(for strTitle: String?)
    func updateData(_ entity: TrendingEntity)
    func updataView()
    func registrerCell()
}

//MARK: - Interactor

/// Interactor -> Presenter
protocol TrendingInteractorOutputProtocol: AnyObject {
    func onReceivedMovies(_ entity: TrendingEntity)
    func showMoviesError(_ error: Error)
}

/// Presenter -> Interactor
protocol TrendingInteractorInputProtocol: AnyObject {
    var presenter: TrendingInteractorOutputProtocol? { get set }
    var remoteDatamanager: TrendingRemoteDataManagerInputProtocol? { get set }
    var entity: TrendingEntity? { get set }
    
    func getNavTitle() -> String?
    func fetchMovies()
}

//MARK: - Presenter

/// View -> Presenter
typealias TrendingPresenterProtocols = TrendingPresenterProtocol & TrendingInteractorOutputProtocol
protocol TrendingPresenterProtocol: AnyObject {
    var view: TrendingViewProtocol? { get set }
    var interactor: TrendingInteractorInputProtocol? { get set }
    var router: TrendingRouterProtocol? { get set }
    
    func viewDidLoad()
    func willFetchMovies()
}

//MARK: - Router

/// Presenter -> Router
protocol TrendingRouterProtocol: AnyObject {
    static func createTrendingModule(entity: TrendingEntity) -> UIViewController
}

//MARK: - Data Manager

/// Interactor -> Remote data manager
protocol TrendingRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: TrendingRemoteDataManagerOutputProtocol? { get set }
    func getMoviesTrending()
    func getNowPlaying()
    func getPopular()
    func getTopRated()
    func getUpcoming()
}

/// Remote data manager -> Interactor
protocol TrendingRemoteDataManagerOutputProtocol: AnyObject {
    func handleGetMovies(_ result: [Movie])
    func handleGetNowPlaying(_ result: [Movie])
    func handleGetPopular(_ result: [Movie])
    func handleGetTopRated(_ result: [Movie])
    func handleGetUpcoming(_ result: [Movie])
    func handleGetErrorServiceMovies(_ error: Error)
}
