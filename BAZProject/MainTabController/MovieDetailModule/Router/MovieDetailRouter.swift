//
//  MovieDetailRouter.swift
//  BAZProject
//
//  Created by 989438 on 27/04/23.
//

import UIKit

final class MovieDetailRouter: MovieDetailRouterProtocol {
    
    func createMovieDetailModule(withMovie movie: [MovieDetailModel]) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let movieDetailView = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as? MovieDetailViewController else { return UIViewController() }
        let interactor = MovieDetailInteractor()
        let presenter = MovieDetailPresenter()
        let service = ServiceDispatchDecorator(decoratee: ServiceAPI(session: URLSession.shared))
        let detailRemoteData = MovieDetailDataManager(service: service)
        
        movieDetailView.presenter = presenter
        movieDetailView.storageObject = UserDefaults.standard
        presenter.movieModel = movie
        presenter.linkDependencies(view: movieDetailView, router: self, interactor: interactor)
        interactor.linkDependencies(remoteData: detailRemoteData, presenter: presenter)
        detailRemoteData.interactor = interactor
        
        return movieDetailView
    }
    
    func presentDetailViewController(from view: MovieDetailViewControllerProtocol?, withMovie movie: [MovieDetailModel]) {
        guard let viewController: UIViewController = view as? UIViewController else { return }
        let movieDetailRouter: MovieDetailRouterProtocol = MovieDetailRouter()
        let movieDetail = movieDetailRouter.createMovieDetailModule(withMovie: movie)
        movieDetail.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(movieDetail, animated: true)
    }
}
