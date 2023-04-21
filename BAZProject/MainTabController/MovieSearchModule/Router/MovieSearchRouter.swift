//
//  MovieSearchRouter.swift
//  BAZProject
//
//  Created by 989438 on 18/04/23.
//

import UIKit

final class MovieSearchRouter: MovieSearchRouterProtocol {
    func createSearchMovieModule() -> UIViewController {
        let searchView = SearchMoviesViewController()
        let interactor = MovieSearchInteractor()
        let presenter = MovieSearchPresenter()
        let service = ServiceDispatchDecorator(decoratee: ServiceAPI(session: URLSession.shared))
        let searchRemoteData = MovieSearchDataManager(service: service)
        
        searchView.presenter = presenter
        presenter.linkDependencies(view: searchView, router: self, interactor: interactor)
        interactor.linkDependencies(remoteData: searchRemoteData, presenter: presenter)
        searchRemoteData.interactor = interactor
        
        return searchView
    }
    
    func presentDetailViewController(from view: MovieSearchViewControllerProtocol?) {
        guard let viewController: UIViewController = view as? UIViewController else { return }
        let emptyViewController = MovieDetailViewController()
        viewController.navigationController?.pushViewController(emptyViewController, animated: true)
    }
}
