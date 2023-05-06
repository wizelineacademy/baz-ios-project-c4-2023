//
//  DetailRouter.swift
//  BAZProject
//
//  Created by jehernandezg on 03/05/23.
//

import UIKit

// MARK: - Class
class DetailRouter {
    // MARK: - Properties
    weak var view: UIViewController?
    //private var animationView: UIAlertController?
    
    // MARK: - Functions
    static func createModule(withMovie movie: ListMovieProtocol) -> UIViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        let presenter = DetailPresenter(view: view, interactor: interactor, router: router, detailMovie: movie)
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        return view
    }
}

// MARK: - Extensions
extension DetailRouter: DetailRouterProtocol {
//    func showAnimation(completion: @escaping () -> Void) {
//        animationView = UIAlertController.GlobalViews.animationView
//        DispatchQueue.main.async {
//            self.view?.present(self.animationView ?? UIAlertController(), animated: true, completion: {
//                completion()
//            })
//        }
//    }
//
//    func hideAnimation(completion: @escaping () -> Void) {
//        DispatchQueue.main.async {
//            self.animationView?.dismiss(animated: true, completion: {
//                completion()
//            })
//        }
//    }
    
}

