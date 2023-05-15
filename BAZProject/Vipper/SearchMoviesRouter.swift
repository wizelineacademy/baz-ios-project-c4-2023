//
//  SearchMoviesRouter.swift
//  BAZProject
//
//  Created by nmorenoa on 14/04/23.
//

import Foundation
import UIKit

final class SearchMoviesRouter: SearchMoviesRouterProtocol{
    
    // MARK: Properties
    weak var view: SearchMoviesView?
    
    //MARK: Functions
    static func createModule() -> SearchMoviesView {
        let movieApi = MovieAPI(session: URLSession.shared)
        let view        = SearchMoviesView()
        let interactor  = SearchMoviesInteractor(movieApi: movieApi)
        let router      = SearchMoviesRouter()
        
        let presenter = SearchMoviesPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        return view
    }
    
    func presentAlert(_ alert: UIAlertController) {
        view?.present(alert, animated: true)
    }
    
    func pushDetailVC(with infoMovie: MovieData?){
        let viewController = MoviesDetailRouter.createModule(with: infoMovie)
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
