//
//  TabBarController.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 19/04/23.
//

import UIKit
///Clase que implementa un 'TabBarController' para la pantalla de Home
final class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers =  setUpViewController()
    }
    
    /// Esta funcion regresa un arreglo de UIViewController que requere un TabBarController
    /// - parameters:
    /// - returns:
    ///   Devuelve un arreglo de UIViewController's `
    func setUpViewController() -> [UIViewController]{
        return [createBarController(for: .trendeing)]
    }
    /// Esta funcion regresa un UIViewController que implementa un TabBarItem
    /// - parameters:
    ///    - controller: Enum TabViewControllers que contine la estructura de un tabBarITem
    /// - returns:
    ///   Devuelve un TabViewControllers
    private func createBarController(for controller: TabViewControllers) -> UIViewController{
        let navBarController = UINavigationController(rootViewController: controller.controller)
        navBarController.tabBarItem.title = controller.title
        navBarController.tabBarItem.image = controller.image
        controller.controller.navigationItem.title = controller.title
        return navBarController
    }
}
