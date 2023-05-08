//
//  HomeRouter.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 02/05/23.
//

import Foundation
import UIKit

class HomeRouter: PresenterToRouterHomeProtocol {
    
    var router: PresenterToRouterHomeProtocol?
    var view: RouterToViewHomeProtocol?
    
    public static func ensambleModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "HomeView", bundle: nil)
        if let viewcontroller = storyboard.instantiateViewController(withIdentifier: "HomeViewId") as? HomeViewController {
            
            let presenterInstance = Presenter()
            let interactorIntance = Interactor()
            let routerInstance = HomeRouter()
            
            viewcontroller.presenter = presenterInstance
            presenterInstance.interactor = interactorIntance
            interactorIntance.presenter = presenterInstance
            presenterInstance.view = viewcontroller
            presenterInstance.router = routerInstance
            routerInstance.view = viewcontroller
            
            return viewcontroller
            
        } else {
            return UIViewController()
        }
    }
    
    func showDetail(item: Viewable) {
        print("Object recieved in router")
        let vc = DetailRouter.ensambleModule(with: item as! Movie)
        view?.presentDetail(vc: vc)
    }
}
