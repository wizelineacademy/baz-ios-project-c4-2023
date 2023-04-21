//
//  UpcomingWireFrame.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation
import UIKit

class UpcomingRouter: UpcomingRouterProtocol {
    
    class func createUpcomingModule() -> UIViewController {
        let view = mainStoryboard.instantiateViewController(withIdentifier: "UpcomingView") as! UpcomingView
        let presenter: UpcomingPresenterProtocol & UpcomingInteractorOutputProtocol = UpcomingPresenter()
        let interactor: UpcomingInteractorInputProtocol & UpcomingRemoteDataManagerOutputProtocol = UpcomingInteractor()
        let remoteDataManager: UpcomingRemoteDataManagerInputProtocol = UpcomingRemoteDataManager(service: ServiceAPI(session: URLSession.shared))
        let router: UpcomingRouterProtocol = UpcomingRouter()
        
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
