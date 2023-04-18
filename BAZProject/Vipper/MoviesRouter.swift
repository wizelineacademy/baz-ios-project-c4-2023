//
//  MoviesRouter.swift
//  BAZProject
//
//  Created by nmorenoa on 14/04/23.
//

import Foundation
import UIKit

class MoviesRouter: MoviesRouterProtocol{
    
    weak var view: MoviesView?
    
    //MARK: Functions
    static func createModule() -> MoviesView {
        let view        = MoviesView()
        let interactor  = MoviesInteractor()
        let router      = MoviesRouter()
        
        let presenter = MoviesPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        return view
    }
    
    func presentAlert(_ alert: UIAlertController, from view: MoviesViewInputProtocol) {
        if let view = view as? MoviesView{
            view.present(alert, animated: true)
        }
    }
    
}
