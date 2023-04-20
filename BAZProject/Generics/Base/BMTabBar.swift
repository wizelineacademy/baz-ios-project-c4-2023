//
//  BMTabBar.swift
//  BAZProject
//
//  Created by bvelazquezva on 19/04/23.
//

import UIKit

class BMTabBar: UITabBarController {

    let Trending = UINavigationController(rootViewController: TrendingViewController())
    let Search = UINavigationController(rootViewController: SearchRouter.createSearchModule(withEntity: SearchEntity(strNavBarTitle: "Search")))
    var arrViews: [UIViewController] =  []
    
        
        override func viewDidLoad() {
            super.viewDidLoad()
            arrViews = [Trending, Search]
            self.setViewControllers(arrViews, animated: true)
            
            let trendingIcon: UIImage = UIImage.init(systemName: "chart.line.uptrend.xyaxis.circle.fill") ?? UIImage()
            
            let searchIcon: UIImage = UIImage.init(systemName: "magnifyingglass") ?? UIImage()
            guard let items = self.tabBar.items else { return }
            
            items[0].title = "Trending"
            items[0].image = trendingIcon
            items[1].title = "Busqueda"
            items[1].image = searchIcon
            
            
//            self.tabBar.backgroundColor = .black
//            self.tabBar.tintColor = .white
        }


}
