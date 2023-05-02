//
//  MoviesDetailRouter.swift
//  BAZProject
//
//  Created by nmorenoa on 25/04/23.
//

import Foundation
import UIKit

final class MoviesDetailRouter: MoviesDetailRouterProtocol{
    
    // MARK: Properties
    weak var view: MoviesDetailView?
    
    //MARK: Functions
    static func createModule(with moviesInfo: MovieData?) -> MoviesDetailView {
        let movieApi = MovieAPI(session: URLSession.shared)
        let view        = MoviesDetailView()
        let interactor  = MoviesDetailInteractor(movieApi: movieApi, moviesInfo: moviesInfo)
        let router      = MoviesDetailRouter()
        
        let presenter = MoviesDetailPresenter(view: view, interactor: interactor, router: router)
        view.presenter          = presenter
        interactor.presenter    = presenter
        router.view             = view
        return view
    }
    
}
