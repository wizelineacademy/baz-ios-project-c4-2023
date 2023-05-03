//
//  MainViewController.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 29/03/23.
//

import UIKit

// MARK: - Class
class MainViewController: UITabBarController {

    // MARK: - Properties

    // MARK: - Override Functions Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupItems()
    }
    
    // MARK: - Private Functions
    /**
     Metodo que carga los UITabBarItem para el UITabBarController
     */
    private func setupItems() {
        let moviesNav = setupBarItem(MoviesViewController(), "Movies", UIImage(systemName: "tv"), UIImage(systemName: "tv"))

        let searchNav = setupBarItem(SearchViewController(), "Search", UIImage(systemName: "magnifyingglass"), UIImage(systemName: "magnifyingglass"))
        selectedIndex = 0
        self.viewControllers = [moviesNav,searchNav]
    }

    /**
     Metodo que carga el UITabBarItem para el UITabBarController
     - Parameter screem: ViewController que se asignara al UINavigationController
     - Parameter title: Titulo que se mostrara en el UITabBarItem
     - Parameter image: Imagen "normal" para mostrar el UITabBarItem
     - Parameter imageSelect: Imagen "seleccionada" para indicar que el UITabBarItem resalte
     */
    private func setupBarItem(_ screen: UIViewController, _ title: String, _ image: UIImage?, _ imageSelect: UIImage?) -> UINavigationController {
        let nav = UINavigationController(rootViewController: screen)
        let tabItem = UITabBarItem(title: title, image: image, selectedImage: imageSelect)
        screen.tabBarItem = tabItem
        return nav
    }
}
