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
        let trendingMoviesModel = TrendingMoviesViewModel(remoteData: TrendingMoviesRemoteData())
        tabBarVC.setViewControllers([TrendingMoviesViewController(model: trendingMoviesModel)], animated: true)
        return tabBarVC
    }

}
