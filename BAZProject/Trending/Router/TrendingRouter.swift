//
//  TrendingRouter.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import Foundation
import UIKit

class TrendingRouter: TrendingRouterProtocol {

    class func createTrendingModule(entity: TrendingEntity) -> UIViewController {
        let view = TrendingViewController()
        let presenter: TrendingPresenterProtocol & TrendingInteractorOutputProtocol = TrendingPresenter()
        let interactor: TrendingInteractorInputProtocol & TrendingRemoteDataManagerOutputProtocol = TrendingInteractor()
        let remoteDataManager: TrendingRemoteDataManagerInputProtocol = TrendingRemoteDataManager()
        let entity: TrendingEntity = entity
        let router: TrendingRouterProtocol = TrendingRouter()
        
        view.presenter = presenter
        view.entity = entity
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        interactor.entity = entity
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
}
