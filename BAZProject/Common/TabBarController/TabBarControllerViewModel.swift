//
//  TabBarControllerViewModel.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 19/04/23.
//

import UIKit

protocol TabElements{
    var controller: UIViewController { get }
    var title: String { get }
    var image: UIImage? { get }
}

enum TabViewControllers: TabElements{
    case trendeing
}

extension TabViewControllers{
    var controller: UIViewController{
        switch self {
        case .trendeing:
            return TrendingMoviesRouter.createModule()
        }
    }
    
    var title: String{
        switch self {
        case .trendeing:
            return "Trending"
        }
    }
    
    var image: UIImage?{
        switch self {
        case .trendeing:
            return UIImage(systemName: "chart.line.uptrend.xyaxis.circle.fill")
        }
    }
}

final class TabBarControllerViewModel{

    func setUpViewController() -> [UIViewController]{
        return [createBarController(for: .trendeing)]
    }
    
    private func createBarController(for controller: TabViewControllers) -> UIViewController{
        let navBarController = UINavigationController(rootViewController: controller.controller)
        navBarController.tabBarItem.title = controller.title
        navBarController.tabBarItem.image = controller.image
        controller.controller.navigationItem.title = controller.title
        return navBarController
    }
}
