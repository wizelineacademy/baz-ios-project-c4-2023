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
public protocol TrendingViewProtocol: AnyObject {
    var presenter: TrendingPresenterProtocol? { get set }
    
    func setNavigationTitle(for strTitle: String?)
    func registerXIB()
    func createNavigationButton()
    func reloadTable()
}

//MARK: - Interactor

/// Interactor -> Presenter
public protocol TrendingInteractorOutputProtocol: AnyObject {
    func serviceRespondedSuccess()
    func serviceFailed(withError error: ErrorApi)
}

/// Presenter -> Interactor
public protocol TrendingInteractorInputProtocol: AnyObject {
    var presenter: TrendingInteractorOutputProtocol? { get set }
    var serviceApi: NetworkingProtocol? { get set }
    var entity: TrendingEntity? { get set }
    
    func getNavTitle() -> String?
    func getMovies(withFilter filter: Paths)
    func getNumberOfRows() -> Int?
    func getMovie(forRow iRow: Int) -> Movie?
}

//MARK: - Presenter

/// View -> Presenter
public protocol TrendingPresenterProtocol: AnyObject {
    var view: TrendingViewProtocol? { get set }
    var interactor: TrendingInteractorInputProtocol? { get set }
    var router: TrendingRouterProtocol? { get set }
    
    func viewDidLoad()
    func getNumberOfRows() -> Int?
    func getMovie(forRow iRow: Int) -> Movie?
    func goToDetail(forIndex iRow: Int)
    func barButtonWasPressed()
}

//MARK: - Router

/// Presenter -> Router
public protocol TrendingRouterProtocol: AnyObject {
    static func createTrendingModule(withEntity entity: TrendingEntity) -> UIViewController
    
    func showAlert(withMessage strMessage: String, from view: TrendingViewProtocol?)
    func goToDetail(for movie: Movie, from view: TrendingViewProtocol?)
    func present(_ viewToPresent: UIViewController, from view: TrendingViewProtocol?)
}
