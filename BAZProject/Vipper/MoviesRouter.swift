//
//  MoviesRouter.swift
//  BAZProject
//
//  Created by nmorenoa on 14/04/23.
//

import Foundation
import UIKit

class MoviesRouter: MoviesRouterProtocol{
    
    // MARK: Properties
    weak var view: MoviesView?
    
    //MARK: Functions
    static func createModule() -> MoviesView {
        let movieApi = MovieAPI(session: URLSession.shared)
        let view        = MoviesView()
        let interactor  = MoviesInteractor(movieApi: movieApi)
        let router      = MoviesRouter()
        
        let presenter = MoviesPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        return view
    }
    
    func presentAlert(_ alert: UIAlertController) {
        view?.present(alert, animated: true)
    }
    
}
