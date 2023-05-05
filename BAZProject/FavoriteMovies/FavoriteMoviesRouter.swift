//
//  FavoriteMoviesRouter.swift
//  BAZProject
//
//  Created by Carlos Garcia on 04/05/23.
//

import Foundation
import UIKit

class FavoriteMoviesRouter: FavoriteMoviesRouterProtocol {
    
    private weak var parentController: UIViewController?
    
    init(parentController: UIViewController?) {
        self.parentController = parentController
    }
    
    func present(presenter: FavoriteMoviesPresenterProtocol) {
        let controller = FavoriteMoviesView(presenter: presenter)
        presenter.attach(view: controller)
        if let navigation = parentController?.navigationController {
            navigation.pushViewController(controller, animated: true)
        }
    }
    
    func goToMovieDetailsView(_ movie: MovieInfo, parent: FavoriteMoviesViewProtocol?) {
        MovieDetailsModule.init(baseController: parent as? UIViewController, entity: MovieDetailsEntity(movie: movie)).present()
    }
    
    func popView() {
        self.parentController?.navigationController?.popViewController(animated: true)
    }
}

public final class FavoriteMoviesModule {
    private var presenter: FavoriteMoviesPresenterProtocol

    init(baseController: UIViewController?, entity: FavoriteMoviesEntity = FavoriteMoviesEntity()) {
        let router = FavoriteMoviesRouter(parentController: baseController)
        let interactor = FavoriteMoviesInteractor(
            entity: entity,
            storageManager: StorageManager(storage: FileManager.default)
        )
        self.presenter = FavoriteMoviesPresenter(
            interactor: interactor,
            router: router
        )
    }

    public func present() {
        self.presenter.present()
    }
}
