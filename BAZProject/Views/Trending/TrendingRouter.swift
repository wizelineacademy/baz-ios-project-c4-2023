//
//  TrendingRouter.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 29/03/23.
//  
//

import Foundation
import UIKit

class TrendingRouter: TrendingRouterProtocol {
    class func createTrendingModule(withEntity entity: TrendingEntity = TrendingEntity()) -> UIViewController {
        let view = TrendingView()
        let presenter: TrendingPresenterProtocol & TrendingInteractorOutputProtocol = TrendingPresenter()
        let interactor: TrendingInteractorInputProtocol = TrendingInteractor()
        let router: TrendingRouterProtocol = TrendingRouter()
        let serviceApi: NetworkingProtocol = ServiceApi(configuration: URLConfiguration(path: .trending))
        let favorite: FavoriteSavingManager = FavoriteSavingManager(persistence: UserDefaultsManager())
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.entity = entity
        interactor.serviceApi = serviceApi
        interactor.favorite = favorite
        
        return view
    }
    
    func showAlert(withMessage strMessage: String, from view: TrendingViewProtocol?) {
        let alert = UIAlertController(title: "Error", message: strMessage, preferredStyle: .alert)
        let action = UIAlertAction(title: "Aceptar", style: .default)
        alert.addAction(action)
        present(alert, from: view)
    }
    
    func present(_ viewToPresent: UIViewController, from view: TrendingViewProtocol?) {
        if let view = view as? TrendingView {
            view.present(viewToPresent, animated: true)
        }
    }
    
    func goToDetail(for movie: Movie, from view: TrendingViewProtocol?) {
        if let view = view as? TrendingView {
            let destinationVC = CleanFactory.createDetailModule(withMovie: movie)
            view.navigationController?.pushViewController(destinationVC, animated: true)
        }
    }
}
