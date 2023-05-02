//
//  MovieRouter.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation
import UIKit

class MovieRouter: MovieRouterProtocol {


    class func createModule(endpoint: Endpoint) -> UIViewController {
                
        guard let view = mainStoryboard.instantiateViewController(withIdentifier: "MovieView") as? MovieView else { return UIViewController()
        }
        
        let presenter: MoviePresenterProtocol & MovieInteractorOutputProtocol = MoviePresenter()
        let interactor: MovieInteractorInputProtocol & MovieRemoteDataManagerOutputProtocol = MovieInteractor()
        let remoteDataManager: MovieRemoteDataManagerInputProtocol = MovieRemoteDataManager(service: ServiceAPI(session: URLSession.shared), endpoint: endpoint)
        let router: MovieRouterProtocol = MovieRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}

extension MovieRouter {
    func goToMovieDetail(of movieID: Int, from view: UIViewController) {
        view.present(MovieDetailRouter.createMovieDetailModule(of: movieID), animated: false)
    }
}
