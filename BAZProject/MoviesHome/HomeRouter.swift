//
//  HomeRouter.swift
//  BAZProject
//
//  Created by Carlos Garcia on 20/04/23.
//  
//

import Foundation
import UIKit

class HomeRouter: HomeRouterProtocol {

    class func createHomeModule(withEntity entity: HomeEntity = HomeEntity()) -> UIViewController {
        let view = HomeView()
        let presenter: HomePresenterProtocol & HomeInteractorOutputProtocol = HomePresenter()
        let interactor: HomeInteractorInputProtocol = HomeInteractor()
        let dataManager: MovieAPI = MovieAPI()
        let router: HomeRouterProtocol = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.movieAPI = dataManager
        interactor.entity = entity
        
        return view
    }
    
    func goToMovieDetailsView(_ movie: MovieInfo, parent: HomeViewProtocol?) {
        MovieDetailsModule.init(baseController: parent as? UIViewController, entity: MovieDetailsEntity(movie: movie)).present()
    }
    
    func goToFavoriteMoviesView(parent: HomeViewProtocol?) {
        FavoriteMoviesModule.init(baseController: parent as? UIViewController).present()
    }
}
