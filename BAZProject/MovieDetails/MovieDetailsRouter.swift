//
//  MovieDetailsRouter.swift
//  BAZProject
//
//  Created by Carlos Garcia on 21/04/23.
//  
//

import Foundation
import UIKit

class MovieDetailsRouter: MovieDetailsRouterProtocol {
    
    private weak var parentController: UIViewController?
    
    init(parentController: UIViewController?) {
        self.parentController = parentController
    }
    
    func present(presenter: MovieDetailsPresenterProtocol) {
        let controller = MovieDetailsView(presenter: presenter)
        presenter.attach(view: controller)
        if let navigation = parentController?.navigationController {
            navigation.pushViewController(controller, animated: true)
        }
    }
    
    func goToMovieDetailsView(_ movie: MovieInfo, parent: MovieDetailsViewProtocol?) {
        MovieDetailsModule.init(baseController: parent as? UIViewController, entity: MovieDetailsEntity(movie: movie)).present()
    }
    
    func popView() {
        self.parentController?.navigationController?.popViewController(animated: true)
    }
}

public final class MovieDetailsModule {
    private var presenter: MovieDetailsPresenterProtocol

    init(baseController: UIViewController?, entity: MovieDetailsEntity) {
        let router = MovieDetailsRouter(parentController: baseController)
        let interactor = MovieDetailsInteractor(
            entity: entity,
            movieAPI: MovieAPI(),
            storageManager: StorageManager(storage: FileManager.default)
        )
        self.presenter = MovieDetailsPresenter(
            interactor: interactor,
            router: router
        )
    }

    public func present() {
        self.presenter.present()
    }
}
