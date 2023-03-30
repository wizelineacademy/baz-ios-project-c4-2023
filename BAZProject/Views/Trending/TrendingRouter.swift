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
        let interactor: TrendingInteractorInputProtocol & TrendingRemoteDataManagerOutputProtocol = TrendingInteractor()
        let localDataManager: TrendingLocalDataManagerInputProtocol = TrendingLocalDataManager()
        let remoteDataManager: TrendingRemoteDataManagerInputProtocol = TrendingRemoteDataManager()
        let router: TrendingRouterProtocol = TrendingRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        interactor.entity = entity
        remoteDataManager.remoteRequestHandler = interactor
        
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
