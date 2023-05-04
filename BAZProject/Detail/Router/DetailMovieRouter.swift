//
//  DetailMovieRouter.swift
//  BAZProject
//
//  Created by Ben Frank V. on 03/05/23.
//  
//

import Foundation
import UIKit

class DetailMovieRouter: DetailMovieRouterProtocol {

    //class func createDetailMovieModule(withEntity entity: DetailMovieEntity = DetailMovieEntity()) -> UIViewController {
    class func createDetailMovieModule() -> UIViewController {
        let view = DetailMovieView()
        let presenter: DetailMoviePresenterProtocol & DetailMovieInteractorOutputProtocol = DetailMoviePresenter()
        let interactor: DetailMovieInteractorInputProtocol & DetailMovieRemoteDataManagerOutputProtocol = DetailMovieInteractor()
        //let localDataManager: DetailMovieLocalDataManagerInputProtocol = DetailMovieLocalDataManager()
        let remoteDataManager: DetailMovieRemoteDataManagerInputProtocol = DetailMovieRemoteDataManager()
        let router: DetailMovieRouterProtocol = DetailMovieRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        //interactor.localDatamanager = localDataManager
        interactor.remoteDatamanager = remoteDataManager
        //interactor.entity = entity
        remoteDataManager.remoteRequestHandler = interactor
        
        return view
    }
}
