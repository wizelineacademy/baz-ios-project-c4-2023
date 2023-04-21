//
//  RecentWireFrame.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation
import UIKit

class RecentRouter: RecentRouterProtocol {

    class func createRecentModule() -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "RecentView") as! RecentView
        let presenter: RecentPresenterProtocol & RecentInteractorOutputProtocol = RecentPresenter()
        let interactor: RecentInteractorInputProtocol & RecentRemoteDataManagerOutputProtocol = RecentInteractor()
        let remoteDataManager: RecentRemoteDataManagerInputProtocol = RecentRemoteDataManager(service: ServiceAPI(session: URLSession.shared))
        let router: RecentRouterProtocol = RecentRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
}
