//
//  TrendingProtocols.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 29/03/23.
//  
//

import Foundation
import UIKit

//MARK: - View

/// Presenter -> View
protocol TrendingViewProtocol: AnyObject {
    var presenter: TrendingPresenterProtocol? { get set }
    
    func setNavigationTitle(for strTitle: String?)
    func registerXIB()
    func reloadTable()
}

//MARK: - Interactor

/// Interactor -> Presenter
protocol TrendingInteractorOutputProtocol: AnyObject {
    func serviceRespondedSuccess()
    func serviceFailed(withError error: ErrorApi)
}

/// Presenter -> Interactor
protocol TrendingInteractorInputProtocol: AnyObject {
    var presenter: TrendingInteractorOutputProtocol? { get set }
    var serviceApi: NetworkingProtocol? { get set }
    var entity: TrendingEntity? { get set }
    
    func getNavTitle() -> String?
    func getMovies()
    func getNumberOfRows() -> Int?
    func getMovie(forRow iRow: Int) -> Movie?
}

//MARK: - Presenter

/// View -> Presenter
protocol TrendingPresenterProtocol: AnyObject {
    var view: TrendingViewProtocol? { get set }
    var interactor: TrendingInteractorInputProtocol? { get set }
    var router: TrendingRouterProtocol? { get set }
    
    func viewDidLoad()
    func getNumberOfRows() -> Int?
    func getMovie(forRow iRow: Int) -> Movie?
}

//MARK: - Router

/// Presenter -> Router
protocol TrendingRouterProtocol: AnyObject {
    static func createTrendingModule(withEntity entity: TrendingEntity) -> UIViewController
    
    func showAlert(withMessage strMessage: String, from view: TrendingViewProtocol?)
}
