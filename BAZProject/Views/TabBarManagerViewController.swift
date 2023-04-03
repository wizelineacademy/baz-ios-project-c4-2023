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
        viewControllers = [createNavController(for: TrendingRouter.createTrendingModule(), title: "Trending", image: UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill"))]
    }
    
    private func createNavController(for rootViewController: UIViewController, title: String, image: UIImage?) -> UIViewController {
            let navController = UINavigationController(rootViewController: rootViewController)
            navController.tabBarItem.title = title
            navController.tabBarItem.image = image
            rootViewController.navigationItem.title = title
            return navController
        }
}
