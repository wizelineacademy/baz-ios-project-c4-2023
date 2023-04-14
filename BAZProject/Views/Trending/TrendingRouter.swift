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
        let serviceApi: NetworkingProtocol = ServiceApi<MovieService>(configuration: URLConfiguration(path: .trending))
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.entity = entity
        interactor.serviceApi = serviceApi
        
        return view
    }
    
    func showAlert(withMessage strMessage: String, from view: TrendingViewProtocol?) {
        if let view = view as? TrendingView{
            let alert = UIAlertController(title: "Error", message: strMessage, preferredStyle: .alert)
            let action = UIAlertAction(title: "Aceptar", style: .default)
            alert.addAction(action)
            view.present(alert, animated: true)
        }
    }
    
}
