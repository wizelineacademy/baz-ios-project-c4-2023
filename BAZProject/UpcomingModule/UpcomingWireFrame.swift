//
//  UpcomingWireFrame.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation
import UIKit

class UpcomingWireFrame: UpcomingWireFrameProtocol {

    class func createUpcomingModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "UpcomingView")
        if let view = navController.children.first as? UpcomingView {
            let presenter: UpcomingPresenterProtocol & UpcomingInteractorOutputProtocol = UpcomingPresenter()
            let interactor: UpcomingInteractorInputProtocol & UpcomingRemoteDataManagerOutputProtocol = UpcomingInteractor()
            let localDataManager: UpcomingLocalDataManagerInputProtocol = UpcomingLocalDataManager()
            let remoteDataManager: UpcomingRemoteDataManagerInputProtocol = UpcomingRemoteDataManager()
            let wireFrame: UpcomingWireFrameProtocol = UpcomingWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: Bundle.main)
    }
    
}
