//
//  SearchRouter.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 16/04/23.
//

import UIKit

final class CleanFactory {
    
    private init() {}
    
    static func createSearchModule() -> UIViewController {
        let view = SearchViewController(nibName: "SearchViewController", bundle: nil)
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let serviceApi = ServiceApi(configuration: URLConfiguration(path: .noPath))
        view.interactor = interactor
        interactor.presenter = presenter
        interactor.networkingSearch = serviceApi
        presenter.view = view
        return view
    }
    
    static func createDetailModule(withMovie movie: Movie) -> UIViewController {
        let interactor = DetailInteractor()
        interactor.setUpEntity(withMovie: movie)
        let serviceAPi = ServiceApi(configuration: URLConfiguration(path: .noPath))
        let favorite: FavoriteSavingManager = FavoriteSavingManager(persistence: UserDefaultsManager())
        interactor.favorite = favorite
        interactor.networking = serviceAPi
        let presenter = DetailPresenter()
        interactor.presenter = presenter
        let view = DetailViewController(nibName: "DetailViewController", bundle: nil)
        view.interactor = interactor
        presenter.view = view
        return view
    }
}
