//
//  SearchRouter.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 16/04/23.
//

import Foundation
import UIKit

class CleanFactory {
    static func createSearchModule() -> UIViewController {
        let view = SearchViewController(nibName: "SearchViewController", bundle: nil)
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let serviceApi = ServiceApi<MovieService>(configuration: URLConfiguration(path: .noPath))
        view.interactor = interactor
        interactor.presenter = presenter
        interactor.networkingSearch = serviceApi
        presenter.view = view
        return view
    }
    
    static func createDetailModule(withMovie movie: Movie) -> UIViewController {
        let view = DetailViewController(nibName: "DetailViewController", bundle: nil)
        let interactor = DetailInteractor()
        interactor.setUpEntity(withMovie: movie)
        let presenter = DetailPresenter()
        view.interactor = interactor
        interactor.presenter = presenter
        presenter.view = view
        return view
    }
}
