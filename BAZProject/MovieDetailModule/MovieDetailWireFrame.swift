//
//  MovieDetailWireFrame.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 27/04/23.
//  
//

import UIKit

class MovieDetailRouter: MovieDetailRouterProtocol {
    static func createMovieDetailModule(of movieId: Int) -> UIViewController {
        let view = MovieDetailViewController()
        let presenter: MovieDetailPresenterProtocol & MovieDetailInteractorOutputProtocol = MovieDetailPresenter(movieId: movieId)
        let interactor: MovieDetailInteractorInputProtocol & MovieDetailRemoteDataManagerOutputProtocol = MovieDetailInteractor()
        let remoteDataManager: MovieDetailRemoteDataManagerInputProtocol = MovieDetailRemoteDataManager(service: ServiceAPI(session: URLSession.shared))
        let router: MovieDetailRouterProtocol = MovieDetailRouter()
            
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        //interactor.data = dataFunct
        remoteDataManager.remoteRequestHandler = interactor
            
        return view
    }
}
