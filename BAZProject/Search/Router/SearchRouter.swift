//
//  SearchRouter.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//  
//

import Foundation
import UIKit

class SearchRouter: SearchRouterProtocol {

    class func createSearchModule(withEntity entity: SearchEntity = SearchEntity()) -> UIViewController {
        let view = SearchTableViewController()
        let presenter: SearchPresenterProtocol & SearchInteractorOutputProtocol = SearchPresenter()
        let interactor: SearchInteractorInputProtocol & SearchRemoteDataManagerOutputProtocol = SearchInteractor()
        let remoteDataManager: SearchRemoteDataManagerInputProtocol = SearchRemoteDataManager()
        let router: SearchRouterProtocol = SearchRouter()
        
        view.presenter = presenter
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
