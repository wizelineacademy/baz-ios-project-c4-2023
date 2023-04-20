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

    class func createTrendingModule() -> UIViewController {
        let view = TrendingViewController()
        let presenter: TrendingPresenterProtocol & TrendingInteractorOutputProtocol = TrendingPresenter()
        let interactor: TrendingInteractorInputProtocol & TrendingRemoteDataManagerOutputProtocol = TrendingInteractor()
        let localDataManager: TrendingLocalDataManagerInputProtocol = TrendingLocalDataManager()
        let remoteDataManager: TrendingRemoteDataManagerInputProtocol = TrendingRemoteDataManager()
        let entity: TrendingEntity = TrendingEntity()
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
}
