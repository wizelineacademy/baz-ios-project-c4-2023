//
//  BMTabBar.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//

import UIKit

class BMTabBar: UITabBarController {

    let Trending = UINavigationController(rootViewController: TrendingViewController())
        var arrViews: [UIViewController] =  []
        var bookmarksItemIcon = UIImage()
        var historyItemIcon = UIImage()
        var webItemIcon = UIImage()
        var settingsItemIcon = UIImage()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            arrViews = [Trending]
            self.setViewControllers(arrViews, animated: true)
            
            let trendingIcon: UIImage = UIImage.init(systemName: "chart.line.uptrend.xyaxis.circle.fill") ?? UIImage()
            guard let items = self.tabBar.items else { return }
            
            items[0].title = "Trending"
            items[0].image = trendingIcon
            
            
//            self.tabBar.backgroundColor = .black
//            self.tabBar.tintColor = .white
        }


}
