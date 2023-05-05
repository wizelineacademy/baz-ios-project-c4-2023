//
//  SearchWireFrame.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 10/04/23.
//  
//

import UIKit

class SearchRouter: SearchRouterProtocol {

    class func createSearchModule() -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "SearchView") as! SearchView
        let presenter: SearchPresenterProtocol & SearchInteractorOutputProtocol = SearchPresenter()
        let interactor: SearchInteractorInputProtocol & SearchRemoteDataManagerOutputProtocol = SearchInteractor()
        let remoteDataManager: SearchRemoteDataManagerInputProtocol = SearchRemoteDataManager(service: ServiceAPI(session: URLSession.shared))
        let router: SearchRouterProtocol = SearchRouter()
            
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

extension SearchRouter {
    func goToMovieDetail(of movieID: Int, from view: UIViewController) {
        view.present(MovieDetailRouter.createMovieDetailModule(of: movieID), animated: false)
    }
}
