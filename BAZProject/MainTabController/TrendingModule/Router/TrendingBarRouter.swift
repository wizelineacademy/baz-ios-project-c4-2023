//
//  TrendingBarRouter.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import UIKit

final class TrendingBarRouter: TrendingBarRouterProtocol {
    func createTrendingModule() -> UIViewController {
        let view = TrendingViewController()
        let interactor = TrendingBarInteractor()
        let presenter = TrendingBarPresenter()
        let service = ServiceDispatchDecorator(decoratee: ServiceAPI(session: URLSession.shared))
        let remoteData = TrendingBarDataManager(service: service)
        
        view.presenter = presenter
        presenter.linkDependencies(view: view, router: self, interactor: interactor)
        interactor.linkDependencies(remoteData: remoteData, presenter: presenter)
        remoteData.interactor = interactor
        return view
    }
    
    func presentMovieSearchViewController(from view: TrendingBarViewControllerProtocol?) {
        guard let viewController: UIViewController = view as? UIViewController else { return }
        let searchRouter: MovieSearchRouterProtocol = MovieSearchRouter()
        let searchViewController = searchRouter.createSearchMovieModule()
        searchViewController.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    func presentDetailViewController(from view: TrendingBarViewControllerProtocol?, withMovie movie: [MovieDetailModel]) {
        guard let viewController: UIViewController = view as? UIViewController else { return }
        let movieDetailRouter: MovieDetailRouterProtocol = MovieDetailRouter()
        let movieDetail = movieDetailRouter.createMovieDetailModule(withMovie: movie)
        movieDetail.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(movieDetail, animated: true)
    }
    
    func presentNextViewController(from view: TrendingBarViewControllerProtocol?, to nextView: UIViewController) {
        guard let viewController = view as? UIViewController else { return }
        let nextViewController  = nextView
        nextView.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
