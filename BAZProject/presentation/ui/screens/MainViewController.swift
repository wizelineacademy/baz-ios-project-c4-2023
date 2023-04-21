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
    private func setupItems() {
        let moviesScreen = MoviesViewController()
        let moviesNav = UINavigationController(rootViewController: moviesScreen)
        let moviesTabItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "tv"), selectedImage: UIImage(systemName: "tv"))
        moviesScreen.tabBarItem = moviesTabItem
        
        let searchScreen = SearchViewController()
        let searchNav = UINavigationController(rootViewController: searchScreen)
        let designsTabItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        searchScreen.tabBarItem = designsTabItem
        selectedIndex = 0
        self.viewControllers = [moviesNav,searchNav]
    }
}
