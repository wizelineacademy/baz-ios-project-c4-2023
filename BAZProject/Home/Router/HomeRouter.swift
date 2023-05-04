//
//  HomeRouter.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 02/05/23.
//

import Foundation
import UIKit

class HomeRouter {
    
    public static func ensambleModule() -> UIViewController {
        let vc = HomeViewController(nibName: "HomeView", bundle: nil)
        let presenterInstance = Presenter()
        let interactorInstance = Interactor()
        
        vc.presenter = presenterInstance
        presenterInstance.interactor = interactorInstance
        interactorInstance.presenter = presenterInstance
        presenterInstance.view = vc
        
        return vc
        
    }
}
