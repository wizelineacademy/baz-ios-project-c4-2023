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
        let trendingView = MovieRouter.createModule(endpoint: .trendingMovies)
        let recentView = MovieRouter.createModule(endpoint: .recentsMovies)
        let topRatedView = MovieRouter.createModule(endpoint: .topRatedMovies)
        let upcomingView = MovieRouter.createModule(endpoint: .upcomingMovies)
        let searchingView = SearchRouter.createSearchModule()
        
        mainTabBar.viewControllers = [
            setUpTabBarItem(viewController: trendingView, endpoint: .trendingMovies),
            setUpTabBarItem(viewController: recentView, endpoint: .recentsMovies),
            setUpTabBarItem(viewController: topRatedView, endpoint: .topRatedMovies),
            setUpTabBarItem(viewController: upcomingView, endpoint: .upcomingMovies),
            searchingView
        ]
        
        return mainTabBar
    }
    
    private class func setUpTabBarItem(viewController: UIViewController, endpoint: Endpoint) -> UIViewController {
        
        let title: String
        let image: UIImage?
        let tag: Int
        
        switch endpoint {
        case .trendingMovies:
            title = "Trending"
            image = UIImage(systemName: "trophy")
            tag = 0
            
        case .recentsMovies:
            title = "Recents"
            image = UIImage(systemName: "calendar")
            tag = 1
            
        case .topRatedMovies:
            title = "TopRated"
            image = UIImage(systemName: "square")
            tag = 2
            
        case .upcomingMovies:
            title = "Upcoming"
            image = UIImage(systemName: "book")
            tag = 3
        
        default:
            return viewController
        }
        
        viewController.navigationItem.title = "Trending Movies"
        viewController.tabBarItem = UITabBarItem(title: title, image: image, tag: tag)
        return viewController
    }
}
