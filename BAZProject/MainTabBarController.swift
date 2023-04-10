//
//  MainTabBarController.swift
//  BAZProject
//
//  Created by gescarcega on 28/03/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    static func getInstance() -> MainTabBarController {
        let tabBarVC = MainTabBarController()
        tabBarVC.setViewControllers([TrendingMoviesViewController(model: TrendingMoviesViewModel())], animated: true)
        return tabBarVC
    }

}
