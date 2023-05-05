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
        let storyboard = UIStoryboard(name: "HomeView", bundle: nil)
        if let viewcontroller = storyboard.instantiateViewController(withIdentifier: "HomeViewId") as? HomeViewController {
            
            let presenterInstance = Presenter()
            let interactorIntance = Interactor()
            
            viewcontroller.presenter = presenterInstance
            presenterInstance.interactor = interactorIntance
            interactorIntance.presenter = presenterInstance
            presenterInstance.view = viewcontroller
            
            return viewcontroller
            
        } else {
            return UIViewController()
        }
    }
}
