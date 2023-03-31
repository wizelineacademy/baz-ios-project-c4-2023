//
//  MainTabBarController.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    internal var firstController : UINavigationController?
    var positionSelected: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewControllers()
    }
    
    /**
     Function to initialize viewControllers of tabBarController and set the order of tabBarViewControllers
     */
    
    private func initializeViewControllers() {
        var arrControllers:[UIViewController] = []
        
        let trendingBarRouter = TrendingBarRouter()
        let trendinBarViewController = trendingBarRouter.createTrendingModule()
        firstController = UINavigationController(rootViewController: trendinBarViewController)
        firstController?.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill"), tag: 1)
        firstController?.tabBarItem.tag = 1
        positionSelected = 1
        arrControllers.append(firstController ?? UIViewController())
        
        viewControllers = arrControllers
    }

}
