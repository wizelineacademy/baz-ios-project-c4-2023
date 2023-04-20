//
//  MainTabBarController.swift
//  BAZProject
//
//  Created by gescarcega on 28/03/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        let trendingTab = getTrendingTab()
        setViewControllers([trendingTab], animated: false)
    }
    
    private func getTrendingTab() -> UIViewController {
        let trendingMoviesModel = TrendingMoviesViewModel(remoteData: TrendingMoviesRemoteData())
        return UINavigationController(rootViewController: TrendingMoviesViewController(viewModel: trendingMoviesModel))
    }
}
