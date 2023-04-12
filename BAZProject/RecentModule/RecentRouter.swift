//
//  RecentWireFrame.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation
import UIKit

class RecentWireFrame: RecentWireFrameProtocol {

    class func createRecentModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "RecentView")
        if let view = navController.children.first as? RecentView {
            let presenter: RecentPresenterProtocol & RecentInteractorOutputProtocol = RecentPresenter()
            let interactor: RecentInteractorInputProtocol & RecentRemoteDataManagerOutputProtocol = RecentInteractor()
            let localDataManager: RecentLocalDataManagerInputProtocol = RecentLocalDataManager()
            let remoteDataManager: RecentRemoteDataManagerInputProtocol = RecentRemoteDataManager()
            let wireFrame: RecentWireFrameProtocol = RecentWireFrame()
            
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
