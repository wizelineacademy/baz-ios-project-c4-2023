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
        let viewModel = TrendingMediaViewModel(remoteData: TrendingMediaRemoteData())
        return UINavigationController(rootViewController: TrendingMediaViewController(viewModel: viewModel))
    }
    
}
