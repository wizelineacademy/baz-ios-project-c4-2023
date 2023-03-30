//
//  MovieListRouter.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 30/03/23.
//

import Foundation
import UIKit

class MovieListRouter: MovieListsRouterProtocol {

    weak var viewController: UIViewController?

    static func createModule() -> UIViewController {
        let view = MovieListViewController()
        let interactor = MovieListsInteractor()
        let router = MovieListRouter()
        let presenter = MovieListsPresenter(interface: view, interactor: interactor)
        
        view.presenter = presenter
        interactor.presenter = presenter
        interactor.repository = MovieDataSourceRemote()
        router.viewController = view

        return view
    }
}
