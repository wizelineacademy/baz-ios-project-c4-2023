//
//  TabBabRouter.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 08/04/23.
//

import Foundation
import UIKit

class MainTabBarRouter {
    class func createMainTabBarModule() -> UITabBarController {
        let mainTabBar = UITabBarController()
        let trendingView = TrendingRouter.createTrendingModule()
        let recentView = RecentRouter.createRecentModule()
        let topRatedView = TopRatedRouter.createTopRatedModule()
        let searchingView = SearchRouter.createSearchModule()
        let upcomingView = UpcomingRouter.createUpcomingModule()
        mainTabBar.viewControllers = [trendingView, recentView, upcomingView, topRatedView, searchingView,]
        return mainTabBar
    }
}
