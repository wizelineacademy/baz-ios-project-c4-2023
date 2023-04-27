//
//  TabBarManagerViewController.swift
//  BAZProject
//
//  Created by Daniel Alberto Vazquez Rodriguez on 29/03/23.
//

import Foundation
import UIKit

final class TabBarManagerViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        let trendingVC = createNavController(for: TrendingRouter.createTrendingModule(), title: NSLocalizedString("Trending", comment: "Trending"), image: UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill"))
        let searchVC = createNavController(for: CleanFactory.createSearchModule(), title: NSLocalizedString("Search", comment: "Search"), image: UIImage(systemName: "magnifyingglass"))
        viewControllers = [trendingVC, searchVC]
    }
    
    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        rootViewController.navigationItem.title = title
        return navController
    }
}
