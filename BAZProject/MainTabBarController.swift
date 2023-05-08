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
        let searchTab = getSearchTab()
        setViewControllers([trendingTab, searchTab], animated: false)
    }
    
    private func getTrendingTab() -> UIViewController {
        let viewModel = TrendingMediaViewModel(remoteData: TrendingMediaRemoteData())
        return UINavigationController(rootViewController: TrendingMediaViewController(viewModel: viewModel))
    }
    
    private func getSearchTab() -> UIViewController {
        let viewModel = SearchViewModel(remoteData: SearchRemoteData(), localData: SearchLocalData())
        return UINavigationController(rootViewController: SearchTableViewController(viewModel: viewModel))
    }
    
}
