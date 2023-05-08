//
//  DetailRouter.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 02/05/23.
//

import Foundation
import UIKit

class DetailRouter {
    
    public static func ensambleModule(with movie: Movie) -> UIViewController {
        
        let vc = DetailViewController(nibName: "DetailViewController", bundle: .main)
        // init custom para recibir el movie.
        
//        let presenterInstance = Presenter()
//        let interactorInstance = Interactor()
        
        // TODO: Al crear los presenter, interactor, etc poner PresenterDetail para identificar cuál estoy llamando
        
//        vc.presenter = presenterInstance
//        presenterInstance.interactor = interactorInstance
//        interactorInstance.presenter = presenterInstance
//        presenterInstance.view = vc
        
        vc.model = movie
        
        return vc
    }
}
