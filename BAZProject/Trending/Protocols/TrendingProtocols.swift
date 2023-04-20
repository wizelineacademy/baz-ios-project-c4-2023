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
}

//MARK: - Interactor

/// Interactor -> Presenter
protocol TrendingInteractorOutputProtocol: AnyObject {
}

/// Presenter -> Interactor
protocol TrendingInteractorInputProtocol: AnyObject {
    var presenter: TrendingInteractorOutputProtocol? { get set }
    var localDatamanager: TrendingLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: TrendingRemoteDataManagerInputProtocol? { get set }
    var entity: TrendingEntity? { get set }
    
    func getNavTitle() -> String?
}

//MARK: - Presenter

/// View -> Presenter
protocol TrendingPresenterProtocol: AnyObject {
    var view: TrendingViewProtocol? { get set }
    var interactor: TrendingInteractorInputProtocol? { get set }
    var router: TrendingRouterProtocol? { get set }
    
    func viewDidLoad()
}

//MARK: - Router

/// Presenter -> Router
protocol TrendingRouterProtocol: AnyObject {
    static func createTrendingModule() -> UIViewController
}

//MARK: - Data Manager

/// Interactor -> Remote data manager
protocol TrendingRemoteDataManagerInputProtocol: AnyObject {
    var remoteRequestHandler: TrendingRemoteDataManagerOutputProtocol? { get set }
    func getMovies(completion: @escaping ([Movie]) -> Void)
}

/// Remote data manager -> Interactor
protocol TrendingRemoteDataManagerOutputProtocol: AnyObject {
    
}

/// Interactor -> Local data manager
protocol TrendingLocalDataManagerInputProtocol: AnyObject {
}
